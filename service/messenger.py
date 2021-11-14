from PySide6 import QtNetwork
from PySide6.QtCore import QObject, Signal, Slot, Property
import json
from .Constructor import Constructor
from .DataTypes import Type



class Messenger(QObject):
    __message: str
    __from_id: str
    __to_id: str
    __date_time: str
    __message_id: str

    def __init__(self):
        QObject.__init__(self)

        self.__message = 'Ожидаем сообщение...'
        self.TCP_HOST = '127.0.0.1'
          # QtNetwork.QHostAddress.LocalHost
        self.TCP_SEND_TO_PORT = 6700
        self.socket = None
        self.listenServer = None
        print('created socket')
        self.socket = QtNetwork.QTcpSocket()
        self.create_signals()
        self.create_connection()

    def create_signals(self):
        print('on connected...')
        self.socket.connected.connect(self.on_connected)
        print('on readyRead...')
        self.socket.readyRead.connect(self.__receive_message)
        print('on disconnected...')
        self.socket.disconnected.connect(self.close_connection)
        self.socket.errorOccurred.connect(self.on_error)

    def create_connection(self):
        print('waiting for connection...')
        self.socket.connectToHost(self.TCP_HOST, self.TCP_SEND_TO_PORT)

    def on_error(self):
        print('ERROR')
        print(self.socket.errorString())

    def close_connection(self):
        #print('disconnect from host')
        #self.socket.disconnectFromHost()
        print('reset...')
        self.socket.reset()
        self.create_connection()

    def on_connected(self):
        print('connected to server')
        self.send(Constructor.create_init())

    newMessage = Signal(
        int, int, str, str, str,
        arguments=[
            'fromId',
            'toId',
            'message',
            'dateTime',
            'messageId'
        ])

    def send(self, data):
        if self.socket.isOpen() and self.socket.isValid():
            self.socket.write(data)
            return self.socket.flush()
        return False


    @Slot(str, str, result=bool)
    def sendMessage(self, to_id, message):
        return self.send(Constructor.create_message(
                to_id = to_id,
                message = message
            ))

    def __set_message(self, from_id, to_id, message, date_time, message_id):
        self.__message = message
        self.__from_id = from_id
        self.__to_id = to_id
        self.__date_time = date_time
        self.__message_id = message_id
        self.newMessage.emit(
            self.__from_id,
            self.__to_id,
            self.__message,
            self.__date_time,
            self.__message_id
        )

    

    @Slot()
    def __receive_message(self):
        data = Constructor.parse(bytes(self.socket.readAll()))
        if data['type'] == Type.MESSAGE:
            self.__set_message(
                from_id=data['from_id'],
                to_id=data['to_id'],
                message=data['message'],
                message_id=['message_id'],
                date_time=data['date_time']
            )