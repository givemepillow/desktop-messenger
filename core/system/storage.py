import sqlite3
import os


class Database:
    __cursor = None

    def __init__(self, db_name):
        self.__file_db = sqlite3.connect(db_name)
        #self.__memory_db = sqlite3.connect(':memory:')
        #self.__file_db.backup( self.__memory_db)
        #self.__cursor = self.__memory_db.cursor()
        self.__cursor = self.__file_db.cursor()


    def cursor(self):
        return self.__cursor

    def connection(self):
        #return self.__memory_db
        return self.__file_db
        

    def close(self):
        print("self.__cursor.close()")
        self.__cursor.close()
        """ print("self.__memory_db.backup(self.__file_db)")
        self.__memory_db.backup(self.__file_db)
        print("self.__memory_db.close()")
        self.__memory_db.close() """
        print("self.__file_db.close()")
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
        # if cls.USERS_TABLE not in tables:
        #     cls.__cursor.execute(
        #         f"CREATE TABLE {cls.USERS_TABLE}"\
        #         "(user_id BIGINT PRIMARY KEY, login VARCHAR(25), email VARCHAR(50), "\
        #         "first_name VARCHAR(30), last_name  VARCHAR(30))")
        if cls.MESSAGES_TABLE not in tables:
            cls.__cursor.execute(
                f"CREATE TABLE {cls.MESSAGES_TABLE} "\
                "(message_id BIGINT PRIMARY KEY, from_id INTEGER NOT NULL, "\
                "to_id INTEGER NOT NULL, message VARCHAR(1000), date_time DECIMAIL(17,4) NOT NULL);"
            )
        # FOREIGN KEY (from_id) REFERENCES users(user_id)
        # "FOREIGN KEY (to_id) REFERENCES users(user_id)


    @classmethod
    def save_many_messages(cls, messages):
        cls.__cursor.executemany("INSERT INTO messages(message_id, from_id, to_id, message, date_time)" \
        "VALUES(?, ?, ?, ?, ?);", messages)
        cls.__connection.commit()

    @classmethod
    def get_users_id(cls, my_id):
        cls.__cursor.execute(
            "SELECT DISTINCT from_id, to_id "\
            "FROM messages WHERE to_id = ? OR from_id = ?;", (my_id, my_id))
        return cls.__cursor.fetchall()

    @classmethod
    def have_messages_to_myself(cls, my_id):
        cls.__cursor.execute(
            "SELECT from_id "\
            "FROM messages WHERE to_id = ? AND from_id = to_id;", (my_id, )
        )
        return len(cls.__cursor.fetchall()) > 0

    @classmethod
    def get_last_massage_info(cls, user_id, my_id):
        cls.__cursor.execute(
            "SELECT message, date_time, max(message_id)"\
            "FROM messages WHERE (to_id = ? AND from_id = ?) OR (to_id = ? AND from_id = ?);", (my_id, user_id, user_id, my_id)
        )
        return cls.__cursor.fetchone()

    @classmethod
    def save_message(cls, message_id, from_id, to_id, message, date_time):
        cls.__cursor.execute("INSERT INTO messages(message_id, from_id, to_id, message, date_time)" \
        "VALUES(?, ?, ?, ?, ?);", (message_id, from_id, to_id, message, date_time))
        cls.__connection.commit()

    @classmethod
    def load_messages(cls, to_id, from_id):
        print(f"{to_id=} {from_id=}")
        cls.__cursor.execute("SELECT message_id, from_id, to_id, message, date_time"\
            " FROM messages "\
                "WHERE (to_id = ? AND from_id = ?) OR (to_id = ? AND from_id = ?);",
                (to_id, from_id, from_id, to_id)
            )
        return [list(message) for message in cls.__cursor.fetchall()]

    @classmethod
    def get_last_index(cls, my_id):
        cls.__cursor.execute("SELECT max(message_id)"\
            " FROM messages WHERE to_id = ? OR from_id = ?;",
                (my_id, my_id)
            )
        return  cls.__cursor.fetchone()[0]
    
    @classmethod
    def close(cls):
        print('waite')
        cls.__db.close()
