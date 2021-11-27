from core.protocols import Request, requests


class RequestConstructor:
    @staticmethod
    def __null(var):
        return var if var != '' else None

    @classmethod
    def create(cls, request_type, **kwargs):
        data = dict()
        for field in kwargs:
            data[field] = cls.__null(kwargs[field])
        return Request.construct(
            type=request_type,
            data=requests[request_type].parse_obj(data)
        ).json().encode('utf-8')
