from PySide6.QtCore import QObject, Signal, Slot, Property
from .Dispatcher import AuthorizationDispatcher


class Service(QObject):
    def __init__(self):
        QObject.__init__(self)

    @classmethod
    def __null(cls, var):
        return var if var != '' else None

    @Slot(result=bool)
    def isError(self):
        return AuthorizationDispatcher.server_error_occurred()

    @Slot(result=str)
    def getServerMessage(self):
        return AuthorizationDispatcher.get_server_message()

    @Slot(str, str, str, str, str, result=bool)
    def registration(self, login, email, password, first_name, last_name):
        return AuthorizationDispatcher.registration(
            login=login,
            password=password,
            first_name=first_name,
            last_name=last_name,
            email=email
        )

    @Slot(str, str, result=bool)
    def emailVerification(self, email, login):
        return AuthorizationDispatcher.email_verification(
            login=login,
            email=email
        )

    @Slot(str, str, result=bool)
    def codeVerification(self, email, code):
        return AuthorizationDispatcher.code_verification(
            email=email,
            code=code
        )

    @Slot(str, str, str, result=bool)
    def authentication(self, login, email, password):
        return AuthorizationDispatcher.authentication(
            login=self.__null(login),
            password=self.__null(password),
            email=email if email != '' else None
        )

    @Slot(str, result=bool)
    def availableEmail(self, email):
        return AuthorizationDispatcher.available_email(
            email=email
        )

    @Slot(str, result=bool)
    def availableLogin(self, login):
        return AuthorizationDispatcher.available_login(
            login=login
        )

    @Slot(str, str, result=bool)
    def recoveryEmailVerification(self, email, login):
        return AuthorizationDispatcher.recovery_email_verification(
            email=self.__null(email),
            login=self.__null(login)
        )

    @Slot(str, str, str, result=bool)
    def recoveryCodeVerification(self, email, login, code):
        return AuthorizationDispatcher.recovery_code_verification(
            email=self.__null(email),
            login=self.__null(login),
            code=code
        )

    @Slot(str, str, str, result=bool)
    def newPassword(self, email, login, password):
        return AuthorizationDispatcher.new_password(
            email=self.__null(email),
            login=self.__null(login),
            password=password
        )
