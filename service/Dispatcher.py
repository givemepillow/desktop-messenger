from PySide2.QtCore import Slot, QObject, Signal
from .Service import Service
from .RequestConstructor import RequestConstructor
from .AnswerParser import AnswerParser
from .Answer import Answer

class Account(QObject):
    @Slot(str, str, result=bool)
    def authentication(self, login, password):
        Service.connect()
        Service.send(RequestConstructor.authentication(login, password))
        answer = Service.receive()
        Service.close()
        return AnswerParser.assert_answer(answer, Answer.ACCEPT)

    @Slot(str, str, str, str, str, result=bool)
    def registration(self, login, password, first_name, last_name, email):
        Service.connect()
        Service.send(RequestConstructor.registration(login, password, first_name, last_name, email))
        answer = Service.receive()
        Service.close()
        return AnswerParser.assert_answer(answer, Answer.ACCEPT)

    @Slot(str, str, result=bool)
    def verification(self, email, code):
        Service.connect()
        Service.send(RequestConstructor.verification(email, code))
        answer = Service.receive()
        Service.close()
        return AnswerParser.assert_answer(answer, Answer.ACCEPT)

    @Slot(str, str, result=bool)
    def email_and_login(self, email, login):
        Service.connect()
        Service.send(RequestConstructor.email_and_login(email, login))
        answer = Service.receive()
        Service.close()
        return AnswerParser.assert_answer(answer, Answer.ACCEPT)