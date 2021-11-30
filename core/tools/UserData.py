import os

class UserData:
    __my_id = None
    __my_login = None
    __my_email = None
    __my_first_name = None
    __my_last_name = None
    __temp_pass = None


    @staticmethod
    def __dir():
        if not os.path.exists('data'):
            os.makedirs('data')

    @classmethod
    def save_password_temporarty(cls, password):
        cls.__temp_pass = password

    @classmethod
    def get_temporary_password(cls):
        return cls.__temp_pass if cls.__temp_pass else ''


    @classmethod
    def save(cls, login=None, email=None, my_id=None, password=None, first_name=None, last_name=None):
        if (email != '' and email): cls.__set_my_email(email)
        if (my_id != '' and my_id): cls.__set_my_id(my_id)
        if (login != '' and login): cls.__set_my_login(login)
        if (password != '' and password): cls.__set_password(password)
        if (first_name != '' and first_name): cls.__set_first_name(first_name)
        if (last_name != '' and last_name): cls.__set_last_name(last_name)


    @classmethod
    def clear(cls):
        cls.__set_my_email('')
        cls.__set_my_login('')
        cls.__set_password(b'')
        cls.__set_first_name('')
        cls.__set_last_name('')
        cls.save_password_temporarty('')


    @classmethod
    def __set_my_id(cls, my_id):
        cls.__dir()
        with open('data/id', 'w') as f:
            f.write(str(my_id))
        cls.__my_id = my_id


    @classmethod
    def __set_first_name(cls, first_name):
        cls.__my_first_name = first_name


    @classmethod
    def get_my_first_name(cls):
        return cls.__my_first_name


    @classmethod
    def get_my_last_name(cls):
        return cls.__my_last_name


    @classmethod
    def __set_last_name(cls, last_name):
        cls.__my_last_name = last_name


    @classmethod
    def get_my_id(cls):
        cls.__dir()
        if cls.__my_id is None:
            with open('data/id', 'a+') as f:
                f.seek(0)
                my_id = f.read()
                if my_id != '':
                    cls.__my_id = int(my_id)
        return cls.__my_id


    @classmethod
    def __set_password(cls, password):
        cls.__dir()
        with open('data/password', 'wb') as f:
            f.write(password)

    @classmethod
    def __set_my_login(cls, login):
        cls.__dir()
        with open('data/login', 'w') as f:
            f.write(login)
        cls.__my_login = login


    @classmethod
    def get_my_login(cls):
        cls.__dir()
        if cls.__my_login is None:
            with open('data/login', 'a+') as f:
                f.seek(0)
                my_login = f.read()
                cls.__my_login = my_login if my_login != '' else None
        return cls.__my_login


    @classmethod
    def get_my_email(cls):
        cls.__dir()
        if cls.__my_email is None:
            with open('data/email', 'a+') as f:
                f.seek(0)
                my_email = f.read()
                cls.__my_email = my_email if my_email != '' else None
        return cls.__my_email 


    @classmethod
    def __set_my_email(cls, email):
        cls.__dir()
        with open('data/email', 'w') as f:
            f.write(email)
        cls.__my_email = email

    @classmethod
    def get_password(cls):
        cls.__dir()
        with open('data/password', 'ab+') as f:
            f.seek(0)
            return f.read()