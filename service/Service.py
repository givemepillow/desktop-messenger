import socket

class Service:

    BUFFER_SIZE = 1024
    PORT = 6767
    ADDRESS = '127.0.0.1'

    @classmethod
    def connect(cls):
        try:
            cls.__socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            cls.__socket.connect((cls.ADDRESS, cls.PORT),)
        except ConnectionRefusedError as e:
            print(e)

    def close(cls):
        s.__socket.close()

    @classmethod
    def send(cls, data):
        cls.__socket.sendall(bytes(data, encoding="utf-8"))
        
    def receive(cls):
        data = cls.__socket.recv(self.BUFFER_SIZE)
        return data.decode("utf-8")
