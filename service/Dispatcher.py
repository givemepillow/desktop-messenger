from typing import Optional

from service.Request import RequestType
from service.RequestConstructor import RequestConstructor
from service.AnswerParser import AnswerParser
from service.Answer import AnswerType
from service.network import Network
from service.Security import Security


class AuthorizationDispatcher:
    __network = Network()

    __server_message: Optional[str]
    __default_server_message = 'Неизвестная ошибка.'

    __server_error = False

    @classmethod
    def get_server_message(cls):
        msg = cls.__server_message if cls.__server_message else cls.__default_server_message
        cls.__server_message = None
        return msg

    @classmethod
    def server_error_occurred(cls):
        return cls.__server_error

    @classmethod
    def __set_server_message(cls, answer):
        if answer.type == AnswerType.ERROR:
            cls.__server_error = True
        else:
            cls.__server_error = False
        cls.__server_message = answer.data.message

    @classmethod
    def __update_encryption_key(cls):
        try:
            if not Security.have_key():
                Security.update_encryption_key(cls.encryption_key())
        except TypeError:
            return False
        return True

    @classmethod
    def authentication(cls, login, email, password):
        if not cls.__update_encryption_key():
            return False
        cls.__network.send(
            RequestConstructor.create(
                request_type=RequestType.AUTHENTICATION,
                login=login,
                password=Security.encrypt(password),
                email=email
            ))
        answer = AnswerParser.extract_answer(cls.__network.receive())
        cls.__set_server_message(answer)
        return answer.type == AnswerType.ACCEPT

    @classmethod
    def registration(cls, login, password, first_name, last_name, email):
        if not cls.__update_encryption_key():
            return False
        cls.__network.send(
            RequestConstructor.create(
                request_type=RequestType.REGISTRATION,
                login=login,
                password=Security.encrypt(password),
                first_name=first_name,
                last_name=last_name,
                email=email
            ))
        answer = AnswerParser.extract_answer(cls.__network.receive())
        cls.__set_server_message(answer)
        return answer.type == AnswerType.ACCEPT

    @classmethod
    def email_verification(cls, email, login):
        cls.__network.send(
            RequestConstructor.create(
                request_type=RequestType.EMAIL_VERIFICATION,
                email=email,
                login=login
            ))
        answer = AnswerParser.extract_answer(cls.__network.receive())
        cls.__set_server_message(answer)
        return answer.type == AnswerType.ACCEPT

    @classmethod
    def code_verification(cls, email, code):
        cls.__network.send(
            RequestConstructor.create(
                request_type=RequestType.CODE_VERIFICATION,
                email=email,
                code=code
            ))
        answer = AnswerParser.extract_answer(cls.__network.receive())
        cls.__set_server_message(answer)
        return answer.type == AnswerType.ACCEPT

    @classmethod
    def encryption_key(cls):
        cls.__network.send(RequestConstructor.create(
            request_type=RequestType.ENCRYPTION_KEY
        ))
        answer = AnswerParser.extract_answer(cls.__network.receive())
        if answer.type != AnswerType.KEY:
            cls.__set_server_message(answer)
            raise TypeError("Ошибка при получении ключа шифрования!")
        return answer.data.key
