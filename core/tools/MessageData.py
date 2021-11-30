from core.system import Storage

class MessageData:
    __chats = set()
    __my_id = None

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
    def update_chats_from_storage(cls):
        users_id = Storage.get_users_id(cls.__my_id)
        cls.__chats.update([message[i] for message in users_id for i in (0, 1)])
        if not Storage.have_messages_to_myself(cls.__my_id):
            cls.__chats.discard(cls.__my_id)

    @classmethod
    def add_chat(cls, from_id, to_id):
        if from_id != cls.__my_id or from_id == to_id:
            cls.__chats.add(from_id) # Add to chat users.
        if to_id != cls.__my_id:
            cls.__chats.add(to_id) # Add to chat users. 