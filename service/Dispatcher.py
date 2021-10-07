from PySide2.QtCore import Slot, QObject, Signal
from .Service import Service
from .RequestConstractor import RequestConstarctor
from .AnswerParser import AnswerParser
from .Answer import Answer

class Account(QObject):
    @Slot(str, str, result=bool)
    def authentication(self, login, password):
        Service.send(RequestConstarctor.authentication(login, password))
        answer = Service.receive()
        return AnswerParser.assert_answer(answer, Answer.AUTHENTICATION_ACCEPTED)

    """ @Slot(str, str, str, str, str, result=bool)
    def registration(self, login, password, first_name, last_name, email):
        try :
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
        except ConnectionRefusedError: 
            return Answer.failed
        return answer.status """
