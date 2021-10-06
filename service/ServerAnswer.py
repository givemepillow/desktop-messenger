import json

class Answer:
    def __init__(self, answer):
        data = json.loads(answer) 
        self.status = data['status']