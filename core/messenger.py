from PySide6.QtCore import QObject, Signal, Slot, Property
import json

from core.system import Network, Storage
from core.converters import MessageConstructor
from core.protocols import Type

class Messenger(Network):
    TCP_HOST = '127.0.0.1'
    TCP_SEND_TO_PORT = 6700
    __current_target_id = -1

    def __init__(self):
        super(Messenger, self).__init__(address='127.0.0.1', port=6700)
        self.socket.connected.connect(self.__init_messenger_session)
        self.socket.readyRead.connect(self.__receive_message)
        self._Network__create_connection()
        #self.__storage = Storage()



    def __new_message(self, data):
        # save message
        Storage().save_message(
            message_id=data['message_id'],
            from_id=data['from_id'],
            to_id=data['to_id'], # Local from global to!
            message=data['message'],
            date_time=data['date_time']
        )
        self.newMessage.emit(
            data['from_id'],
            data['to_id'],
            data['message'],
            data['date_time'],
            data['message_id']
        )

    def __init(self, data):
        ...

    def __on_error(self):
        print('ERROR: ', self.socket.errorString())

    def __close_connection(self):
        #print('disconnect from host')
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
            Type.INIT: self.__init
        }
        answer = self.__parse(data)
        handlers[answer['type']](answer)

    def __parse(self, raw_message):
        return json.loads(raw_message.decode('utf-8'))

    @Slot(str, result=bool)
    def sendMessage(self, message):
        return self.send(MessageConstructor.create_message(
                to_id = self.__current_target_id,
                message = message
            ))

    @Slot(int)
    def updateTraget(self, to_id):
        self.__current_target_id = to_id

    @Slot(result=bool)
    def haveAnyMessages(self):
        return False

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

    def __receive_message(self):
        self.handle(bytes(self.socket.readAll()))
