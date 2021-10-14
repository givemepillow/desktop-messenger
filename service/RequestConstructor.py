import socket

from .Request import Request, RequestType, requests

from .Security import Security


class RequestConstructor:
    hostname = socket.gethostname()
    local_ip = socket.gethostbyname(hostname)

    public_key = None

    @classmethod
    def encryption_key(cls, email=None, login=None):
        return Request(
            type=RequestType.ENCRYPTION_KEY,
            ip=cls.local_ip,
            data=requests[RequestType.ENCRYPTION_KEY](
                login=login,
                email=email
            )
        ).json()

    @classmethod
    def authentication(cls, login, email, password):
        return Request(
            type=RequestType.AUTHENTICATION,
            ip=cls.local_ip,
            data=requests[RequestType.AUTHENTICATION](
                login=login,
                email=email,
                password=password
            )
        ).json()

    @classmethod
    def registration(cls, login, password, first_name, last_name, email):
        return Request(
            type=RequestType.REGISTRATION,
            ip=cls.local_ip,
            data=requests[RequestType.REGISTRATION](
                login=login,
                email=email,
                password=Security.encrypt(password),
                last_name=last_name,
                first_name=first_name
            )
        ).json()

    @classmethod
    def email_verification(cls, email, code):
        return Request(
            type=RequestType.EMAIL_VERIFICATION,
            ip=cls.local_ip,
            data=requests[RequestType.EMAIL_VERIFICATION](
                email=email,
                code=code
            )
        ).json()

    @classmethod
    def code_verification(cls, email, code):
        return Request(
            type=RequestType.CODE_VERIFICATION,
            ip=cls.local_ip,
            data=requests[RequestType.CODE_VERIFICATION](
                email=email,
                code=code
            )
        ).json()
