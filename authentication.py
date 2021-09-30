from PySide2.QtCore import Slot, QObject, Signal
from PySide2.QtCore import QTimer
import socket
import json

class Verify(QObject):
    @Slot(str, str, result=bool)
    def check_login_and_password(self, login, password):
        HOST = '127.0.0.1'
        PORT = 6767

        data = {'login': login, 'password': password}
        to_send = json.dumps(data)

        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((HOST, PORT))
            s.sendall(bytes(to_send, encoding="utf-8"))
            data = s.recv(1024)
            answer = json.loads(data.decode("utf-8"))
        return answer['ok']
