from service.AnswerParser import AnswerParser
from service.RemoteServer import RemoteServer
from service.RequestConstructor import RequestConstructor


def authentication(login, email, password):
    request = RequestConstructor.authentication(login, email, password)
    answer = RemoteServer.data_exchange(request)
    return AnswerParser.extract_answer(answer)
