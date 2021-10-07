from .Request import Request
import json


class RequestConstructor:
    @classmethod
    def authentication(cls, login, password):
        return json.dumps({
            'type': Request.AUTHENTICATION_REQUEST,
            'login': login,
            'password': password
        })

    @classmethod
    def registration(cls, login, password, first_name, last_name, email):
        return json.dumps({
            'type': Request.REGISTRATION_REQUEST,
            'login': login,
            'password': password,
            'email': email,
            'first_name': first_name,
            'last_name': last_name
        })

    @classmethod
    def verification(cls, email, code):
        return json.dumps({
            'type': Request.VERIFICATION_REQUEST,
            'email': email,
            'code': code
        })

    @classmethod
    def email_and_login(cls, email, login):
        return json.dumps({
            'type': Request.EMAIL_AND_LOGIN_REQUEST,
            'email': email,
            'login': login
        })
