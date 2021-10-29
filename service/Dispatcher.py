from typing import Optional

from service.Requests import RequestType
from service.RequestConstructor import RequestConstructor
from service.ResponseParser import ResponseParser
from service.Responses import ResponseType
from service.network import Network
from service.Security import Security


class AuthorizationDispatcher:
    __network = Network()
    __server_message = None
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
    def __receive(cls):
        try:
            answer = ResponseParser.extract_answer(cls.__network.receive())
            cls.__set_server_message(answer)
            return answer.type == ResponseType.ACCEPT
        except IOError as e:
            cls.__server_message = e
            cls.__server_error = True
            return False

    @classmethod
    def __set_server_message(cls, answer):
        if answer.type == ResponseType.ERROR:
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
        return cls.__receive()

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
        return cls.__receive()

    @classmethod
    def email_verification(cls, email, login):
        cls.__network.send(
            RequestConstructor.create(
                request_type=RequestType.EMAIL_VERIFICATION,
                email=email,
                login=login
            ))
        return cls.__receive()

    @classmethod
    def code_verification(cls, email, code):
        cls.__network.send(
            RequestConstructor.create(
                request_type=RequestType.CODE_VERIFICATION,
                email=email,
                code=code
            ))
        return cls.__receive()

    @classmethod
    def encryption_key(cls):
        cls.__network.send(RequestConstructor.create(
            request_type=RequestType.ENCRYPTION_KEY
        ))
        answer = ResponseParser.extract_answer(cls.__network.receive())
        if answer.type != ResponseType.KEY:
            cls.__set_server_message(answer)
            raise TypeError("Ошибка при получении ключа шифрования!")
        return answer.data.key

    @classmethod
    def available_email(cls, email):
        cls.__network.send(RequestConstructor.create(
            request_type=RequestType.AVAILABLE_EMAIL,
            email=email
        ))
        return cls.__receive()

    @classmethod
    def available_login(cls, login):
        cls.__network.send(RequestConstructor.create(
            request_type=RequestType.AVAILABLE_LOGIN,
            login=login
        ))
        return cls.__receive()
