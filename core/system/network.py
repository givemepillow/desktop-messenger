from PySide6 import QtNetwork
from PySide6.QtCore import QObject, Signal, QTimer


class Network(QObject):
    # Connection status.
    __alive = False
    __timer_interval = 1000
    __reconnection_tries = 0

    def __init__(self, address, port):
        QObject.__init__(self)
        self.TCP_HOST = address
        self.TCP_SEND_TO_PORT = port
        self.socket = None
        self.listenServer = None
        self.socket = QtNetwork.QTcpSocket()
        self.__timer = QTimer(self)
        self.__timer.setInterval(self.__timer_interval)
        self.__timer.timeout.connect(self.__create_connection)
        self.__create_signals()


    def __create_signals(self):
        self.socket.errorOccurred.connect(self.__on_error)
        self.socket.disconnected.connect(self.__on_disconnect)
        self.socket.connected.connect(self.__on_connected)


    def __on_connected(self):
        print("Connected to Server!")


    def __process_timer(self):
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

        

    def __create_connection(self):
        print("try to connect...")
        self.socket.connectToHost(self.TCP_HOST, self.TCP_SEND_TO_PORT)
        self.__alive = self.socket.waitForConnected(50)
        self.__process_timer()
        return self.__alive


    def __on_error(self):
        self.__alive = False
        print("error: ", self.socket.errorString())


    def __on_disconnect(self):
        print('disconnected from server')
        self.socket.disconnectFromHost()
        self.__create_connection()


    def _send(self, data: bytes):
        self.socket.write(data)
        self.__alive = self.socket.flush()
        return self.__alive


    def _receive(self):
        if self.socket.waitForReadyRead(1000):
            return self.socket.read(1024 * 5)
        else:
            raise IOError("Не удалось подключиться к серверу :(")