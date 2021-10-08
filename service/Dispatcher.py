from PySide2.QtCore import Slot, QObject, Signal
from .Service import Service
from .RequestConstructor import RequestConstructor
from .AnswerParser import AnswerParser
from .Answer import Answer

class Account(QObject):

    server_message = ''

    @Slot(str, str, result=bool)
    def authentication(self, login, password):
        Service.connect()
        Service.send(RequestConstructor.authentication(login, password))
        answer = AnswerParser.extract_answer(Service.receive())
        Service.close()
        self.server_message = answer['message']
        return answer['type'] == Answer.ACCEPT

    @Slot(str, str, str, str, str, result=bool)
    def registration(self, login, password, first_name, last_name, email):
        Service.connect()
        Service.send(RequestConstructor.registration(login, password, first_name, last_name, email))
        answer = AnswerParser.extract_answer(Service.receive())
        Service.close()
        self.server_message = answer['message']
        return answer['type'] == Answer.ACCEPT

    @Slot(str, str, result=bool)
    def verification(self, email, code):
        Service.connect()
        Service.send(RequestConstructor.verification(email, code))
        answer = AnswerParser.extract_answer(Service.receive())
        Service.close()
        self.server_message = answer['message']
        return answer['type'] == Answer.ACCEPT

    @Slot(str, str, result=bool)
    def email_and_login(self, email, login):
        Service.connect()
        Service.send(RequestConstructor.email_and_login(email, login))
        answer = AnswerParser.extract_answer(Service.receive())
        Service.close()
        self.server_message = answer['message']
        return answer['type'] == Answer.ACCEPT

    @Slot(result=str)
    def get_server_message(self):
        msg = self.server_message
        self.server_message = ""
        return msg