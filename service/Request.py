import json

class Request:
    AUTHENTICATION_REQUEST = 1

    @classmethod
    def authentication(cls, login, password):
        return json.dumps({
            'request_type': cls.AUTHENTICATION_REQUEST,
            'login': login,
            'password': password
        })
