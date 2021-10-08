class Request:
    # request starts with 1, code length - 3
    # answers starts with 2, code length - 3
    AUTHENTICATION_REQUEST = 101
    REGISTRATION_REQUEST = 102
    CODE_VERIFICATION_REQUEST = 103
    EMAIL_VERIFICATION_REQUEST = 104
