from PySide6.QtCore import QObject, Signal, Slot, Property

from typing import Optional

from core.system import Network
from core.protocols import RequestType, ResponseType
from core.converters import RequestConstructor, ResponseParser
from core.tools import Security, UserData


class Service(Network):
    # Error info.
    __server_message = None
    __server_message: Optional[str]
    __default_server_message = 'Нет подключения к серверу.'
    __server_error = True

    __online = None
    __offline = None

    __auth_complete = False


    def __init__(self):
        super(Service, self).__init__(address='127.0.0.1', port=6767)
        self.socket.connected.connect(self.__get_encryption_key)
        self.socket.connected.connect(self.__update_authentication)
        self._Network__create_connection()

    @Slot(result=bool)
    def isError(self):
        return self.__server_error

    @Slot(result=int)
    def getMyId(self):
        return UserData.get_my_id()

    @Slot(result=str)
    def getMyFirstName(self):
        return UserData.get_my_first_name()

    @Slot(result=str)
    def getMyLastName(self):
        return UserData.get_my_last_name()

    @Slot(result=str)
    def getMyLogin(self):
        return UserData.get_my_login()

    @Slot(result=str)
    def getServerMessage(self):
        return self.__get_server_message()

    @Slot(str, str, str, str, str, result=bool)
    def registration(self, login, email, password, first_name, last_name):
        if not Security.key_is_set() or not self._send(
            RequestConstructor.create(
                request_type=RequestType.REGISTRATION,
                login=login,
                password=Security.encrypt(password),
                first_name=first_name,
                last_name=last_name,
                email=email
            )): return False
        return self.__receive()

    @Slot(str, str, result=bool)
    def emailVerification(self, email, login):
        self._send(
            RequestConstructor.create(
                request_type=RequestType.EMAIL_VERIFICATION,
                email=email,
                login=login
            ))
        return self.__receive()

    @Slot(str, str, result=bool)
    def codeVerification(self, email, code):
        self._send(
            RequestConstructor.create(
                request_type=RequestType.CODE_VERIFICATION,
                email=email,
                code=code
            ))
        return self.__receive()

    @Slot(int, result=float)
    def getUserOnlineStatus(self, user_id):
        self._send(
            RequestConstructor.create(
                request_type=RequestType.USER_STATUS,
                user_id=user_id
            )
        )
        response = self.receive()
        if response.data.is_online == True:
            return 0
        else:
            return response.data.last_seen

    @Slot(result=int)
    def getOnline(self):
        self._send(
            RequestConstructor.create(
                request_type=RequestType.STATS
            )
        )
        response = self.receive()
        self.__online = response.data.online if response is not None else 0
        self.__offline = response.data.offline if response is not None else 0
        return self.__online or 0

    @Slot(result=int)
    def getOffline(self):
        return self.__offline or 0

    @Slot()
    def logout(self):
        UserData.clear()
        self._send(RequestConstructor.create(
                request_type=RequestType.LOGOUT
        ))
        self.receive()

    @Slot(str, result=list)
    def search(self, keywords):
        keywords = keywords.split()
        if len(keywords) == 1:
            self._send(RequestConstructor.create(
                request_type=RequestType.SEARCH,
                keyword1 = keywords[0]
            ))
            response = self.receive()
            return [[user['id'], user['login'], user['first_name'], user['last_name']] for user in response.data.users]
        elif len(keywords) == 2:
            self._send(RequestConstructor.create(
                request_type=RequestType.SEARCH,
                keyword1=keywords[0],
                keyword2=keywords[1] 
            ))
            response = self.receive()
            return [[user['id'], user['login'], user['first_name'], user['last_name']] for user in response.data.users]
        else:
            return []

    def __update_authentication(self):
        if self.__auth_complete and not self.autoAuthentication():
            self.__server_error = True
            self.__server_message = 'Необходима повторная аутентификация!'

    @Slot(result=bool)
    def autoAuthentication(self):
        password = UserData.get_temporary_password()
        if not Security.key_is_set() or not self._send(
            RequestConstructor.create(
                request_type=RequestType.AUTHENTICATION,
                login=UserData.get_my_login(),
                password=Security.encrypt(password) if password else UserData.get_password(),
                email=UserData.get_my_email()
            )): return False
        response = self.receive()
        if ResponseType(response.type) == ResponseType.AUTH_COMPLETE:
            self.__auth_complete = True
            UserData.save(
                my_id=response.data.user_id,
                password=UserData.get_password(),
                email=UserData.get_my_email(),
                login=response.data.login,
                first_name=response.data.first_name,
                last_name=response.data.last_name
            )
            return True
        else:
            return False

    @Slot(str, str, str, bool, result=bool)
    def authentication(self, login, email, password, save_password):
        if not Security.key_is_set() or not self._send(
            RequestConstructor.create(
                request_type=RequestType.AUTHENTICATION,
                login=login,
                password=Security.encrypt(password),
                email=email
            )): return False
        response =  self.receive()
        if ResponseType(response.type) == ResponseType.AUTH_COMPLETE:
            self.__auth_complete = True
            UserData.save_password_temporarty(password)
            UserData.save(
                my_id=response.data.user_id,
                first_name=response.data.first_name,
                last_name=response.data.last_name,
                login=response.data.login
            )
            if save_password:
                UserData.save(
                    password=Security.encrypt(password),
                    email=email
                )
            print(response.data.user_id)
            return True
        else:
            UserData.clear()
            return False

    @Slot(str, result=bool)
    def availableEmail(self, email):
        self._send(RequestConstructor.create(
            request_type=RequestType.AVAILABLE_EMAIL,
            email=email
        ))
        return self.__receive()

    @Slot(str, result=bool)
    def availableLogin(self, login):
        self._send(RequestConstructor.create(
            request_type=RequestType.AVAILABLE_LOGIN,
            login=login
        ))
        return self.__receive()

    @Slot(str, str, result=bool)
    def recoveryEmailVerification(self, email, login):
        self._send(RequestConstructor.create(
            request_type=RequestType.RECOVERY_EMAIl_VERIFICATION,
            login=login,
            email=email
        ))
        return self.__receive()

    @Slot(str, str, str, result=bool)
    def recoveryCodeVerification(self, email, login, code):
        self._send(RequestConstructor.create(
            request_type=RequestType.RECOVERY_CODE_VERIFICATION,
            login=login,
            email=email,
            code=code
        ))
        return self.__receive()

    @Slot(str, str, str, result=bool)
    def newPassword(self, email, login, password):
        if not Security.key_is_set() or not self._send(
            RequestConstructor.create(
                request_type=RequestType.NEW_PASSWORD,
                login=login,
                email=email,
                password=Security.encrypt(password)
            )): return False
        return self.__receive()
    
    def __encryption_key_verify(self):
        if not Security.key_is_set(): return False

    def __get_encryption_key(self):
        answer = None
        try:
            self._send(RequestConstructor.create(
                request_type=RequestType.ENCRYPTION_KEY
            ))
            answer = ResponseParser.extract_response(self._receive())
        except IOError:
            self.__set_server_message(answer)
            return None
        if ResponseType(answer.type) != ResponseType.KEY:
            raise TypeError("Ошибка при получении ключа шифрования!")
        self.__set_server_message(answer)
        return Security.update_encryption_key(new_key=answer.data.key)

    def receive(self):
        answer = None
        try:
            answer = ResponseParser.extract_response(self._receive())
        except IOError as err:
            pass
        finally:
            self.__set_server_message(answer)
            return answer

    def __receive(self):
        answer, status = None, False
        try:
            answer = ResponseParser.extract_response(self._receive())
            if ResponseType(answer.type) == ResponseType.AUTH_COMPLETE:
                UserData.set_my_id(answer.data.user_id)
                status = True
            else:
                status = (ResponseType(answer.type) == ResponseType.ACCEPT)
        except IOError:
            status = False
        finally:
            self.__set_server_message(answer)
            return status
            
    def __set_server_message(self, answer):
        if answer is None or self._Network__alive == False:
            self.__server_message = 'Сервер не доступен!'
            self.__server_error = True
            return
        elif answer.type == ResponseType.ERROR:
            self.__server_error = True
        else:
            self.__server_error = False
        self.__server_message = answer.data.message

    def __get_server_message(self):
        msg = self.__server_message if self.__server_message else self.__default_server_message
        self.__server_message = None
        return msg