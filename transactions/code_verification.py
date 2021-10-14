from service.AnswerParser import AnswerParser
from service.RemoteServer import RemoteServer
from service.RequestConstructor import RequestConstructor


def code_verification(email, code):
    request = RequestConstructor.code_verification(email=email, code=code)
    answer = RemoteServer.data_exchange(request)
    return AnswerParser.extract_answer(answer)
