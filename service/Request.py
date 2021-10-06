import json

class Request:
    AUTHENTICATION_REQUEST = 1
    REGISTARTION_REQUEST = 2

    @classmethod
    def authentication(cls, login, password):
        return json.dumps({
            'request_type': cls.AUTHENTICATION_REQUEST,
            'login': login,
            'password': password
        })

    @classmethod
    def registration(cls, login, password, first_name, last_name, email):
        return json.dumps({
            'request_type': cls.REGISTARTION_REQUEST,
            'login': login,
            'password': password,
            'email': email,
            'first_name': first_name,
            'last_name': last_name
        })
