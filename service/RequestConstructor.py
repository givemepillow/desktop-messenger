from .Request import Request, RequestType, requests

from .Security import Security


class RequestConstructor:
    @classmethod
    def encryption_key(cls, email=None, login=None):
        return Request(
            type=RequestType.ENCRYPTION_KEY,
            data=requests[RequestType.ENCRYPTION_KEY](
                login=login,
                email=email
            )
        ).json()

    @classmethod
    def authentication(cls, login, email, password):
        return Request(
            type=RequestType.AUTHENTICATION,
            data=requests[RequestType.AUTHENTICATION](
                login=login,
                email=email,
                password=Security.encrypt(password)
            )
        ).json()

    @classmethod
    def registration(cls, login, password, first_name, last_name, email):
        return Request(
            type=RequestType.REGISTRATION,
            data=requests[RequestType.REGISTRATION](
                login=login,
                email=email,
                password=Security.encrypt(password),
                last_name=last_name,
                first_name=first_name
            )
        ).json()

    @classmethod
    def email_verification(cls, email, login):
        return Request(
            type=RequestType.EMAIL_VERIFICATION,
            data=requests[RequestType.EMAIL_VERIFICATION](
                email=email,
                login=login
            )
        ).json()

    @classmethod
    def code_verification(cls, email, code):
        return Request(
            type=RequestType.CODE_VERIFICATION,
            data=requests[RequestType.CODE_VERIFICATION](
                email=email,
                code=code
            )
        ).json()
