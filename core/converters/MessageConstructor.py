import json

from core.protocols import Type
from core.tools import UserData

class MessageConstructor:
    @classmethod
    def __set_meta_data(cls, data):
        data['from_id'] = UserData.get_my_id()
        return json.dumps(data).encode('utf-8')

    @classmethod
    def create_message(cls, to_id, message):
        return cls.__set_meta_data({
            'type': Type.MESSAGE,
            'to_id': int(to_id),
            'message': message,
            'date_time': None,
            'message_id': None
        })
        

    @classmethod
    def create_init(cls):
        return  cls.__set_meta_data({
            'type': Type.INIT
        })