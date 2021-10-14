from service.AnswerParser import AnswerParser
from service.RemoteServer import RemoteServer
from service.RequestConstructor import RequestConstructor


def registration(login, email, first_name, last_name, password):
    request = RequestConstructor.registration(
        login=login,
        email=email,
        first_name=first_name,
        last_name=last_name,
        password=password
    )
    answer = RemoteServer.data_exchange(request)
    return AnswerParser.extract_answer(answer)
