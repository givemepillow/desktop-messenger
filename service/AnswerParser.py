import json

class AnswerParser:
    @classmethod
    def extract_answer(cls, data):
        return json.loads(data)