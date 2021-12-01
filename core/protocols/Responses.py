import enum
from typing import Union, Optional, List

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
    SEARCH_RESULTS: int = 210
    USER_STATUS: int = 209
    USER_INFO: int = 207


class UserInfo(BaseModel):
    user_id: int
    login: str
    first_name: str
    last_name: str
    message: Optional[str]


class UserStatus(BaseModel):
    is_online: bool
    last_seen: Optional[float]
    message: str


class SearchResults(BaseModel):
    users: List[Optional[dict]]
    message: Optional[str]


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
    ResponseType.AUTH_COMPLETE: AuthComplete,
    ResponseType.SEARCH_RESULTS: SearchResults,
    ResponseType.USER_STATUS: UserStatus,
    ResponseType.USER_INFO: UserInfo
}


class Response(BaseModel):
    type: ResponseType
    data: Union[
        Error,
        Reject,
        Accept,
        Key,
        Stats,
        AuthComplete,
        SearchResults,
        UserStatus,
        UserInfo
    ]
