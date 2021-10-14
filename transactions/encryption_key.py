from service import RemoteServer, AnswerParser, RequestConstructor


def encryption_key():
    data = RemoteServer.data_exchange(RequestConstructor.encryption_key())
    answer = AnswerParser.extract_answer(data)
    return answer.data.key
