class UserData:
    __my_id = None
    __my_login = None
    __my_email = None

    @classmethod
    def save(cls, login=None, email=None, my_id=None, password=None):
        if (email != '' and email): cls.__set_my_email(email)
        if (my_id != '' and my_id): cls.__set_my_id(my_id)
        if (login != '' and login): cls.__set_my_login(login)
        if (password != '' and password): cls.__set_password(password)

    @classmethod
    def __set_my_id(cls, my_id):
        with open('data/id', 'w') as f:
            f.write(str(my_id))
        cls.__my_id = my_id


    @classmethod
    def get_my_id(cls):
        if cls.__my_id is None:
            with open('data/id', 'a+') as f:
                f.seek(0)
                my_id = f.read()
                cls.__my_id = int(my_id)
        return cls.__my_id


    @classmethod
    def __set_password(cls, password):
        with open('data/password', 'wb') as f:
            f.write(password)

    @classmethod
    def __set_my_login(cls, login):
        with open('data/login', 'w') as f:
            f.write(login)
        cls.__my_login = login


    @classmethod
    def get_my_login(cls):
        if cls.__my_login is None:
            with open('data/login', 'a+') as f:
                f.seek(0)
                my_login = f.read()
                cls.__my_login = my_login if my_login != '' else None
        return cls.__my_login


    @classmethod
    def get_my_email(cls):
        if cls.__my_email is None:
            with open('data/email', 'a+') as f:
                f.seek(0)
                my_email = f.read()
                cls.__my_email = my_email if my_email != '' else None
        return cls.__my_email 


    @classmethod
    def __set_my_email(cls, email):
        with open('data/email', 'w') as f:
            f.write(email)
        cls.__my_email = email

    @classmethod
    def get_password(cls):
        with open('data/password', 'ab+') as f:
            f.seek(0)
            return f.read()