from service.Answer import Answer


class AnswerParser:
    @classmethod
    def extract_answer(cls, data):
        return Answer.parse_raw(data)
