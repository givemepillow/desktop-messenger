from service.Requests import Request, requests


class RequestConstructor:

    @classmethod
    def create(cls, request_type, **kwargs):
        data = dict()
        for field in kwargs:
            data[field] = kwargs[field]
        return Request(type=request_type, data=requests[request_type].parse_obj(data)).json().encode('utf-8')
