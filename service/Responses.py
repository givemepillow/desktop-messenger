import enum
from typing import Union

from pydantic import BaseModel


class ResponseType(enum.Enum):
    # request starts with 1, code length - 3
    # responses starts with 2, code length - 3
    ERROR: int = 201
    REJECT: int = 202
    ACCEPT: int = 203
    KEY: int = 205


class Key(BaseModel):
    key: bytes


class Error(BaseModel):
    message: str


class Reject(BaseModel):
    message: str


class Accept(BaseModel):
    message: str


responses = {
    ResponseType.ERROR: Error,
    ResponseType.REJECT: Reject,
    ResponseType.ACCEPT: Accept,
    ResponseType.KEY: Key
}


class Response(BaseModel):
    type: ResponseType
    data: Union[
        Error,
        Reject,
        Accept,
        Key
    ]