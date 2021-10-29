from PySide6 import QtNetwork
from PySide6.QtCore import QObject, Signal, QTimer


class Network(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.TCP_HOST = "127.0.0.1"
        self.TCP_SEND_TO_PORT = 6767
        self.socket = None
        self.listenServer = None
        self.socket = QtNetwork.QTcpSocket()
        self.create_signals()
        self.create_connection()
        self.__timer = QTimer(self)
        self.__timer.setInterval(1000)

    def create_signals(self):
        self.socket.errorOccurred.connect(self.__error)
        self.socket.disconnected.connect(self.__disconnect)
        self.socket.connected.connect(self.__new_connection)

    @classmethod
    def __new_connection(cls):
        print("Connected to Server!")

    def create_connection(self):
        print('waiting for connection...')
        self.socket.connectToHost(self.TCP_HOST, self.TCP_SEND_TO_PORT)
        while not self.socket.waitForConnected(1000):
            self.socket.connectToHost(self.TCP_HOST, self.TCP_SEND_TO_PORT)

    def __error(self):
        print(self.socket.errorString())
        self.__disconnect()

    def __disconnect(self):
        print('disconnected from server')
        self.socket.disconnectFromHost()
        self.socket.waitForDisconnected(1000)
        self.create_connection()

    def send(self, data: bytes):
        self.socket.write(data)
        return self.socket.flush()

    def receive(self):
        if self.socket.waitForReadyRead(1000):
            return self.socket.read(1024 * 5)
        else:
            raise IOError("Не удалось подключиться к серверу :(")
