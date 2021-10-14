from service.AnswerParser import AnswerParser
from service.RemoteServer import RemoteServer
from service.RequestConstructor import RequestConstructor


def email_verification(login, email):
    request = RequestConstructor.email_verification(login=login, email=email)
    answer = RemoteServer.data_exchange(request)
    return AnswerParser.extract_answer(answer)
