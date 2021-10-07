from .Request import Request
import json


class RequestConstarctor:
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
