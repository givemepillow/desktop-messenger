from PySide6 import QtNetwork
from PySide6.QtCore import QObject, Signal, Slot, Property
import json
from .Constructor import Constructor
from .DataTypes import Type

class Messenger(QObject):
    TCP_HOST = '127.0.0.1'
    TCP_SEND_TO_PORT = 6700
    socket = None
    listenServer = None

    def __init__(self):
        QObject.__init__(self)
        self.socket = QtNetwork.QTcpSocket()
        self.create_signals()
        self.create_connection()


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


    def create_signals(self):
        self.socket.connected.connect(self.__on_connected)
        self.socket.readyRead.connect(self.__receive_message)
        self.socket.disconnected.connect(self.__close_connection)
        self.socket.errorOccurred.connect(self.__on_error)

    def create_connection(self):
        print('waiting for connection...')
        self.socket.connectToHost(self.TCP_HOST, self.TCP_SEND_TO_PORT)

    def __on_error(self):
        print('ERROR: ', self.socket.errorString())

    def __close_connection(self):
        #print('disconnect from host')
        self.socket.disconnectFromHost()
        self.create_connection()

    def __on_connected(self):
        print('connected to server')
        self.send(Constructor.create_init())

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
        return self.send(Constructor.create_message(
                to_id = to_id,
                message = message
            ))

    newMessage = Signal(
        int, int, str, str, str,
        arguments=[
            'fromId',
            'toId',
            'message',
            'dateTime',
            'messageId'
        ])

    def __receive_message(self):
        self.handle(bytes(self.socket.readAll()))
