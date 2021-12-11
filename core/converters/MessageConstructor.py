import json

from core.protocols import Type
from core.tools import UserData, MessageData
from core.system import Storage

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
    def create_delete_dialog(cls, to_id):
        return cls.__set_meta_data({
            'type': Type.DELETE_DIALOG,
            'to_id': int(to_id),
            'last_update': MessageData.get_last_update()
        })

    @classmethod
    def create_init(cls):
        return  cls.__set_meta_data({
            'type': Type.INIT,
            'to_id': UserData.get_my_id(),
            'last_message_id': Storage.get_last_index(UserData.get_my_id()),
            'last_update': MessageData.get_last_update()
        })

    @classmethod
    def create_delete_message(cls, to_id, message_id):
        return cls.__set_meta_data({
            'type': Type.DELETE_MASSAGE,
            'to_id': int(to_id),
            'message_id': int(message_id),
            'last_update': MessageData.get_last_update()
        })
