import json

class AnswerParser:
    @classmethod
    def assert_answer(cls, answer, answer_type):
        answer = json.dumps(answer)
        return answer['type'] == answer_type