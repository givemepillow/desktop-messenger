from PySide6.QtCore import QObject, Signal, Slot, Property
import json

from core.system import Network
from core.converters import MessageConstructor
from core.protocols import Type

class Messenger(Network):
    TCP_HOST = '127.0.0.1'
    TCP_SEND_TO_PORT = 6700

    def __init__(self):
        super(Messenger, self).__init__(address='127.0.0.1', port=6700)
        self.socket.connected.connect(self.__init_messenger_session)
        self.socket.readyRead.connect(self.__receive_message)
        self._Network__create_connection()
        #self.__storage = Storage()



    def __new_message(self, data):
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

    @Slot(str, str, result=bool)
    def sendMessage(self, to_id, message):
        return self.send(MessageConstructor.create_message(
                to_id = to_id,
                message = message
            ))

    newMessage = Signal(
        int, int, str, float, str,
        arguments=[
            'fromId',
            'toId',
            'message',
            'dateTime',
            'messageId'
        ])

    def __receive_message(self):
        self.handle(bytes(self.socket.readAll()))
