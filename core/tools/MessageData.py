from core.system import Storage
import os

class MessageData:
    __chats = set()
    read_chats = dict()
    __my_id = None
    chat_users = dict()
    __get_user_info = None
    __last_update = -1

    @staticmethod
    def __dir():
        if not os.path.exists('data'):
            os.makedirs('data')

    @classmethod
    def set_last_update(cls, last_update_time):
        cls.__dir()
        with open('data/last_update', 'w') as f:
            f.write(str(last_update_time))
        cls.__last_update = last_update_time

    @classmethod
    def get_last_update(cls):
        cls.__dir()
        if cls.__last_update is -1:
            with open('data/last_update', 'a+') as f:
                f.seek(0)
                last_update = f.read()
                if last_update != '':
                    cls.__last_update = float(last_update)
        return cls.__last_update


    @classmethod
    def set_get_user_info(cls, func):
        cls.__get_user_info = func

    @classmethod
    def init(cls, my_id):
        cls.__my_id = my_id

    @classmethod
    def get_chats(cls):
        return tuple(cls.__chats) or tuple()

    @classmethod
    def is_local_chat(cls, user_id):
        return user_id in cls.__chats

    @classmethod
    def update_chat(cls, user_id, message, date_time, message_id):
        cls.chat_users[user_id]['last_message'] = message
        cls.chat_users[user_id]['last_message_time'] = date_time
        cls.chat_users[user_id]['message_id'] = message_id

    @classmethod
    def update_chats_from_storage(cls):
        users_id = Storage.get_users_id(cls.__my_id)
        cls.__chats.update([message[i] for message in users_id for i in (0, 1)])
        if not Storage.have_messages_to_myself(cls.__my_id):
            cls.__chats.discard(cls.__my_id)
        for user_id in cls.__chats:
            cls.__set_user_info(user_id)

    @classmethod
    def add_chat(cls, user_id):
        if user_id not in cls.__chats:
            cls.__chats.add(user_id) # Add to chat users.
            cls.__set_user_info(user_id=user_id)

    @classmethod
    def remove_chat(cls, user_id):
        cls.__chats.discard(user_id)
        del cls.chat_users[user_id]

    @classmethod
    def __set_user_info(cls, user_id):
        data = Storage.get_last_massage_info(user_id, cls.__my_id)
        info = cls.__get_user_info(user_id)
        cls.chat_users[user_id] = {
            'contact_name': ' '.join([info.first_name, info.last_name]),
            'last_message': data[0], # from db
            'last_message_time': data[1], # from db
            'contact_login': info.login,
            'contact_id': user_id, # from server
            'message_id': data[2]
        }
