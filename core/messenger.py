from PySide6.QtCore import QObject, Signal, Slot, Property
import json

from core.system import Network, Storage
from core.converters import MessageConstructor
from core.protocols import Type
from core.tools import UserData, MessageData

class Messenger(Network):
    __current_target_id = -1
    __my_id = None

    def __init__(self):
        super(Messenger, self).__init__(address='127.0.0.1', port=6700) # '89.223.71.146'
        self.socket.connected.connect(self.__init_messenger_session)
        self.socket.readyRead.connect(self.__receive_message)
        self._Network__create_connection()
        MessageData.update_chats_from_storage()
        self.__my_id = UserData.get_my_id()

    def __new_message(self, data):
        _from, _to = data['from_id'], data['to_id']
        Storage().save_message(
            message_id=data['message_id'],
            from_id=_from,
            to_id=_to, # Local from global to!
            message=data['message'],
            date_time=data['date_time']
        )
        user_id = self.__extract_user_id(_from, _to)
        MessageData.add_chat(user_id)
        MessageData.update_chat(user_id, data['message'], data['date_time'],  data['message_id'])
        if self.__current_target_id == user_id:
            self.newMessage.emit(
                data['from_id'],
                data['to_id'],
                data['message'],
                data['date_time'],
                data['message_id'],
            )
        else:
            Storage.set_read(user_id)
        self.reloadContacts.emit()

    def __extract_user_id(self, from_id, to_id):
        return from_id if from_id != self.__my_id or from_id == to_id else to_id

    def __init(self, data):
        if data['last_update'] != MessageData.get_last_update():
            Storage.clear()
            MessageData.set_last_update(data['last_update'])
        Storage.save_many_messages(data['messages'])
        MessageData.update_chats_from_storage()
        self.reloadContacts.emit()

    @Slot(int)
    def deleteChat(self, user_id):
        return self.send(MessageConstructor.create_delete_dialog(
            to_id = user_id
        ))

    @Slot(int)
    def deleteMessage(self, message_id):
        return self.send(MessageConstructor.create_delete_message(
            to_id=self.__current_target_id,
            message_id = message_id
        ))

    def __deleting_dialog(self, data):
        _from, _to = data['from_id'], data['to_id']
        user_id = self.__extract_user_id(_from, _to)
        MessageData.remove_chat(user_id=user_id)
        Storage.clear_chat(_from, _to)
        MessageData.update_chats_from_storage()
        self.deleteChatSignal.emit()

    def __deleting_message(self, data):
        _message_id = data['message_id']
        Storage.remove_message(_message_id)
        self.deleteChatSignal.emit()
    
    @Slot(result=list)
    def loadMessages(self):
        return Storage.load_messages(self.__current_target_id, UserData.get_my_id())

    @Slot(int, result=str)
    def getLastMessage(self, user_id):
        if user_id not in MessageData.chat_users:
            return 'Нет ни одного сообщения'
        _last_message = MessageData.chat_users[user_id]['last_message'].split('\n')
        return _last_message[0][0:20]

    @Slot(int, result=float)
    def getLastMessageTime(self, user_id):
        if user_id not in MessageData.chat_users:
            return -1
        return MessageData.chat_users[user_id]['last_message_time']


    def __close_connection(self):
        self.socket.disconnectFromHost()
        self.create_connection()

    def __init_messenger_session(self):
        self.send(MessageConstructor.create_init())

    def send(self, data):
        if self.socket.isOpen() and self.socket.isValid():
            self.socket.write(data)
            return self.socket.flush()
        return False
    

    def handle(self, data):
        handlers = {
            Type.MESSAGE: self.__new_message,
            Type.INIT: self.__init,
            Type.DELETE_DIALOG: self.__deleting_dialog,
            Type.DELETE_MASSAGE: self.__deleting_message
        }
        answer = self.__parse(data)
        handlers[answer['type']](answer)

    def __parse(self, raw_message):
        return json.loads(raw_message.decode('utf-8'))

    @Slot(str, result=bool)
    def sendMessage(self, message):
        return self.send(MessageConstructor.create_message(
                to_id = self.__current_target_id,
                message = message.strip()
            ))

    @Slot(int)
    def updateTraget(self, to_id):
        self.__current_target_id = to_id

    @Slot(int, result=bool)
    def haveAnyMessages(self, user_id):
        return user_id in MessageData.chat_users

    @Slot(int, result=bool)
    def isRead(self, user_id):
        _read = Storage.is_read(user_id)
        return not (user_id in MessageData.chat_users and _read[0] == 0)

    @Slot(int)
    def markAsRead(self, user_id):
       Storage.mark_as_read(user_id)

    @Slot(result=int)
    def getTarget(self):
        return self.__current_target_id

    newMessage = Signal(
        int, int, str, float, int,
        arguments=[
            'fromId',
            'toId',
            'message',
            'dateTime',
            'messageId'
        ])

    loaded = Signal()
    reloadContacts = Signal()
    deleteChatSignal = Signal()

    def __receive_message(self):
        self.handle(bytes(self.socket.readAll()))
