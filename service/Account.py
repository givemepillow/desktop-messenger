from PySide2.QtCore import Slot, QObject, Signal
from PySide2.QtCore import QTimer
import socket
import json
from .Request import Request
from .ServerAnswer import Answer

class Account(QObject):

    BUFFER_SIZE = 1024

    @Slot(str, str, result=bool)
    def authentication(self, login, password):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect(('127.0.0.1', 6767))
            s.sendall(bytes(Request.authentication(login, password), encoding="utf-8"))
            data = s.recv(self.BUFFER_SIZE)
            answer = Answer(data.decode("utf-8"))
        return answer.status

    @Slot(str, str, str, str, str, result=bool)
    def registration(self, login, password, first_name, last_name, email):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            req = Request.registration(
                login=login.strip(),
                password=password.strip(),
                first_name=first_name.strip(),
                last_name=last_name.strip(),
                email=email.strip()
            )
            s.connect(('127.0.0.1', 6767))
            s.sendall(bytes(req, encoding="utf-8"))
            data = s.recv(self.BUFFER_SIZE)
            answer = Answer(data.decode("utf-8"))
        return answer.status
