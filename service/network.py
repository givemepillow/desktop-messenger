from PySide6 import QtNetwork
from PySide6.QtCore import QObject, Signal, QTimer


class Network(QObject):

    __alive = False
    __timer_interval = 1000
    __reconnection_tries = 0

    def __init__(self):
        QObject.__init__(self)
        self.TCP_HOST = "127.0.0.1"
        self.TCP_SEND_TO_PORT = 6767
        self.socket = None
        self.listenServer = None
        self.socket = QtNetwork.QTcpSocket()
        self.__timer = QTimer(self)
        self.__timer.setInterval(self.__timer_interval)
        self.__timer.timeout.connect(self.__create_connection)
        self.__create_signals()
        
        

    def __create_signals(self):
        self.socket.errorOccurred.connect(self.__error)
        self.socket.disconnected.connect(self.__disconnect)
        self.socket.connected.connect(self.__new_connection)

    def __new_connection(cls):
        print("Connected to Server!")
        

    def __create_connection(self):
        print("try to connect...")
        self.socket.connectToHost(self.TCP_HOST, self.TCP_SEND_TO_PORT)
        self.__alive = self.socket.waitForConnected(100)
        if not self.__alive:
            if self.__timer.isActive():
                if self.__reconnection_tries > 60 * 15:
                    self.__timer_interval = 5000
                else:
                    self.__reconnection_tries += 1
            else:
                self.__timer.start()
        else:
            self.__timer_interval = 1000
            self.__reconnection_tries = 0
            self.__timer.stop()
        return self.__alive

    def __error(self):
        self.__alive = False
        #self.__reconnect()
        print("error: ", self.socket.errorString())

    def __disconnect(self):
        print('disconnected from server')
        self.socket.disconnectFromHost()
        self.__create_connection()

    def send(self, data: bytes):
        if not self.__alive and not self.__create_connection():
            return False
        self.socket.write(data)
        self.__alive = self.socket.flush()
        return self.__alive 

    def receive(self):
        if self.socket.waitForReadyRead(1000):
            return self.socket.read(1024 * 5)
        else:
            raise IOError("Не удалось подключиться к серверу :(")
