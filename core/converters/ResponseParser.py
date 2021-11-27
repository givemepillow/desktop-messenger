import json
from json import JSONDecodeError

from core.protocols import ResponseType, Response, responses

class ResponseParser:
    @classmethod
    def extract_response(cls, data) -> Response:
        json_response = json.loads(bytes(data))
        try:
            parsed_response = Response.construct(
                type=json_response['type'],
                data=responses[ResponseType(json_response['type'])].parse_obj(json_response['data'])
            )
            print(parsed_response)
        except JSONDecodeError:
            raise ValueError('Получен невалидный запрос.')
        return parsed_response
