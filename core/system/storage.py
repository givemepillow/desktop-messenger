import sqlite3

class Connection:
    def __init__(self):
        self.__connection  = sqlite3.connect('storage.db')

    def get_connection(self):
        return self.__connection

    def close_connection(self):
        self.__connection.close()


class StorageInitializer:
    def __init__(self, connection):
        self.__connection = connection

    def run():
        ...



class Storage:
    ...

