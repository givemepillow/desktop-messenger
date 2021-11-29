import sqlite3
import os


class Database:
    __cursor = None

    def __init__(self, db_name):
        self.__file_db = sqlite3.connect(db_name)
        self.__memory_db = sqlite3.connect(':memory:')
        self.__file_db.backup( self.__memory_db)
        self.__cursor = self.__memory_db.cursor()


    def cursor(self):
        return self.__cursor

    def connection(self):
        return self.__memory_db
        

    def close(self):
        self.__cursor.close()
        self.__memory_db.backup(self.__file_db)
        self.__memory_db.close()
        self.__file_db.close()


    def __del__(self):
        self.close()
        print("end")


class Storage:
    __users = set()
    __cursor = None
    __connection = None
    USERS_TABLE = 'users'
    MESSAGES_TABLE = 'messages'
    
    @classmethod
    def initialize(cls):
        if not os.path.exists('data'):
            os.makedirs('data')
        cls.__db = Database('data/storage.db')
        cls.__cursor = cls.__db.cursor()
        cls.__connection = cls.__db.connection()
        # Checking for the existence of a table.
        cls.__cursor.execute(
            "SELECT name FROM sqlite_master " \
            "WHERE type='table' AND (name=? OR name=?)", (cls.USERS_TABLE, cls.MESSAGES_TABLE))
        tables = [t[0] for t in cls.__cursor.fetchall()]
        print(tables)
        # Creating tables.
        if cls.USERS_TABLE not in tables:
            cls.__cursor.execute(f"CREATE TABLE {cls.USERS_TABLE}"\
                "(user_id BIGINT PRIMARY KEY, login VARCHAR(25), email VARCHAR(50), "\
                    "first_name VARCHAR(30), last_name  VARCHAR(30))")
        if cls.MESSAGES_TABLE not in tables:
            cls.__cursor.execute(f"CREATE TABLE {cls.MESSAGES_TABLE} "\
                "(message_id BIGINT PRIMARY KEY, from_id INTEGER NOT NULL, "\
                    "to_id INTEGER NOT NULL, message VARCHAR(1000), date_time DECIMAIL(17,4));")

    @classmethod
    def save_message(cls, message_id, from_id, to_id, message, date_time):
        cls.__cursor.execute("INSERT INTO messages(message_id, from_id, to_id, message, date_time)" \
        "VALUES(?, ?, ?, ?, ?);", (message_id, from_id, to_id, message, date_time))
        cls.__connection.commit()
    
    @classmethod
    def close(cls):
        cls.__db.close()
