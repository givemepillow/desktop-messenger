from PySide2.QtCore import Slot, QObject, Signal
from PySide2.QtCore import QTimer
import socket
import json
from .Request import Request

class Account(QObject):

    @Slot(str, str, result=bool)
    def authentication(self, login, password):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect(('127.0.0.1', 6767))
            s.sendall(bytes(Request.authentication(login, password), encoding="utf-8"))
            data = s.recv(1024)
            answer = json.loads(data.decode("utf-8"))
        return answer['ok']
