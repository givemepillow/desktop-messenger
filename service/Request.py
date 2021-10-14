import enum
from typing import Optional, Union

from pydantic import BaseModel


class RequestType(enum.Enum):
    # request starts with 1, code length - 3
    # answers starts with 2, code length - 3
    AUTHENTICATION: int = 101
    REGISTRATION: int = 102
    CODE_VERIFICATION: int = 103
    EMAIL_VERIFICATION: int = 104
    ENCRYPTION_KEY: int = 105


class EncryptionKey(BaseModel):
    email: Optional[str]
    login: Optional[str]


class Registration(BaseModel):
    login: str
    email: str
    first_name: str
    last_name: str
    password: bytes


class Authentication(BaseModel):
    login: Optional[str]
    email: Optional[str]
    password: bytes


class EmailVerification(BaseModel):
    email: str
    login: str


class CodeVerification(BaseModel):
    email: str
    code: int


class Request(BaseModel):
    type: RequestType
    data: Union[
        Registration,
        CodeVerification,
        EmailVerification,
        Authentication,
        EncryptionKey
    ]
    ip: str


requests = {
    RequestType.AUTHENTICATION: Authentication,
    RequestType.ENCRYPTION_KEY: EncryptionKey,
    RequestType.REGISTRATION: Registration,
    RequestType.CODE_VERIFICATION: CodeVerification,
    RequestType.EMAIL_VERIFICATION: EmailVerification
}
