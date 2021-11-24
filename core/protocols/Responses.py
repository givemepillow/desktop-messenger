import enum
from typing import Union, Optional

from pydantic import BaseModel


class ResponseType(enum.Enum):
    # request starts with 1, code length - 3
    # responses starts with 2, code length - 3
    ERROR: int = 201
    REJECT: int = 202
    ACCEPT: int = 203
    KEY: int = 205
    STATS: int = 211
    AUTH_COMPLETE: int = 212


class AuthComplete(BaseModel):
    user_id: int
    first_name: str
    last_name: str
    login: str
    message: Optional[str]


class Stats(BaseModel):
    online: int
    offline: int
    message: Optional[str]


class Key(BaseModel):
    key: bytes
    message: Optional[str]


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
    ResponseType.KEY: Key,
    ResponseType.STATS: Stats,
    ResponseType.AUTH_COMPLETE: AuthComplete
}


class Response(BaseModel):
    type: ResponseType
    data: Union[
        Error,
        Reject,
        Accept,
        Key,
        Stats,
        AuthComplete
    ]
