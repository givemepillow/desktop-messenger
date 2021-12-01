import enum
from typing import Optional, Union

from pydantic import BaseModel, Field


class RequestType(enum.Enum):
    # request starts with 1, code length - 3
    # responses starts with 2, code length - 3
    AUTHENTICATION: int = 101
    REGISTRATION: int = 102
    CODE_VERIFICATION: int = 103
    EMAIL_VERIFICATION: int = 104
    ENCRYPTION_KEY: int = 105
    AVAILABLE_EMAIL: int = 106
    AVAILABLE_LOGIN: int = 107
    RECOVERY_EMAIl_VERIFICATION: int = 108
    RECOVERY_CODE_VERIFICATION: int = 109
    NEW_PASSWORD: int = 110
    STATS: int = 111
    SEARCH: int = 112
    LOGOUT: int = 113
    USER_STATUS: int = 114
    USER_INFO: int = 115


class UserStatus(BaseModel):
    user_id: int


class UserInfo(BaseModel):
    user_id: int


class Logout(BaseModel):
    pass


class Stats(BaseModel):
    pass


class Search(BaseModel):
    keyword1: str
    keyword2: Optional[str]


class NewPassword(BaseModel):
    email: Optional[str] = Field(min_length=8, max_length=50)
    login: Optional[str] = Field(min_length=3, max_length=25)
    password: bytes


class AvailableLogin(BaseModel):
    login: str = Field(min_length=3, max_length=25)


class AvailableEmail(BaseModel):
    email: str = Field(min_length=5, max_length=50)


class EncryptionKey(BaseModel):
    email: Optional[str] = Field(min_length=5, max_length=50)
    login: Optional[str] = Field(min_length=3, max_length=25)


class Registration(BaseModel):
    login: str = Field(min_length=3, max_length=25)
    email: str = Field(min_length=5, max_length=50)
    first_name: str = Field(min_length=2, max_length=30)
    last_name: str = Field(min_length=2, max_length=30)
    password: bytes


class Authentication(BaseModel):
    login: Optional[str] = Field(min_length=3, max_length=25)
    email: Optional[str] = Field(min_length=5, max_length=50)
    password: bytes


class EmailVerification(BaseModel):
    email: str = Field(min_length=5, max_length=50)
    login: str = Field(min_length=3, max_length=25)


class CodeVerification(BaseModel):
    email: str = Field(min_length=5, max_length=50)
    code: int = Field(ge=100000, le=999999)


class RecoveryEmailVerification(BaseModel):
    email: Optional[str] = Field(min_length=5, max_length=50)
    login: Optional[str] = Field(min_length=3, max_length=25)


class RecoveryCodeVerification(BaseModel):
    email: Optional[str] = Field(min_length=5, max_length=50)
    login: Optional[str] = Field(min_length=3, max_length=25)
    code: int = Field(ge=100000, le=999999)


class Request(BaseModel):
    type: RequestType
    data: Union[
        Registration,
        CodeVerification,
        EmailVerification,
        Authentication,
        EncryptionKey,
        AvailableLogin,
        AvailableEmail,
        RecoveryEmailVerification,
        RecoveryCodeVerification,
        NewPassword,
        Stats,
        Search,
        Logout,
        UserStatus,
        UserInfo
    ]
    ip: Optional[str]
    port: Optional[int]


requests = {
    RequestType.AUTHENTICATION: Authentication,
    RequestType.ENCRYPTION_KEY: EncryptionKey,
    RequestType.REGISTRATION: Registration,
    RequestType.CODE_VERIFICATION: CodeVerification,
    RequestType.EMAIL_VERIFICATION: EmailVerification,
    RequestType.AVAILABLE_EMAIL: AvailableEmail,
    RequestType.AVAILABLE_LOGIN: AvailableLogin,
    RequestType.RECOVERY_CODE_VERIFICATION: RecoveryCodeVerification,
    RequestType.RECOVERY_EMAIl_VERIFICATION: RecoveryEmailVerification,
    RequestType.NEW_PASSWORD: NewPassword,
    RequestType.STATS: Stats,
    RequestType.SEARCH: Search,
    RequestType.LOGOUT: Logout,
    RequestType.USER_STATUS: UserStatus,
    RequestType.USER_INFO: UserInfo
}
