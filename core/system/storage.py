import sqlite3


class Connection:
    def __init__(self, db_name):
        self.__connection  = sqlite3.connect(db_name)

    def get_connection(self):
        return self.__connection

    def close_connection(self):
        self.__connection.close()


class Storage:
    __users = set()
    

    def __init__(self):
        self.__connection = Connection('storage.db').get_connection()
        self.__initialize()
        self.__load_metadata()

    
    def __initialize(self):
        ...

    def __load_metadata(self):
        ...


    def save_message(self, from_id, message, date_time, index=None):
        ...
