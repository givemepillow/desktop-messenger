import json

class AnswerParser:
    @classmethod
    def assert_answer(cls, data, answer_type):
        answer = json.loads(data)
        return answer['type'] == answer_type