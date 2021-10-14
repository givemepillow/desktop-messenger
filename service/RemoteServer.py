import socket

__all__ = ['RemoteServer']


class Network:
    BUFFER_SIZE = 1024 * 10
    PORT = 6767
    ADDRESS = '127.0.0.1'

    __socket = None

    @classmethod
    def connect(cls):
        try:
            cls.__socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            cls.__socket.connect((cls.ADDRESS, cls.PORT), )
        except ConnectionRefusedError as e:
            print(e)

    @classmethod
    def close(cls):
        cls.__socket.close()

    @classmethod
    def send(cls, data):
        cls.__socket.sendall(bytes(data, encoding="utf-8"))

    @classmethod
    def receive(cls):
        data = cls.__socket.recv(cls.BUFFER_SIZE)
        return data.decode("utf-8")


class RemoteServer:
    @classmethod
    def data_exchange(cls, data):
        Network.connect()
        Network.send(data)
        rec_data = Network.receive()
        Network.close()
        return rec_data

