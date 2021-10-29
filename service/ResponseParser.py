from service.Responses import Response


class ResponseParser:
    @classmethod
    def extract_answer(cls, data):
        return Response.parse_raw(bytes(data))
