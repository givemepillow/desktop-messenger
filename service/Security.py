import base64

from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.asymmetric import padding


class Security:
    key = None

    @classmethod
    def have_key(cls):
        return True if cls.key is not None else False

    @classmethod
    def set_encryption_key(cls, key):
        cls.key = serialization.load_pem_public_key(base64.b64decode(key))

    @classmethod
    def encrypt(cls, data: str):
        if cls.key is None:
            raise ValueError("Ключ шифрования не был получен!")
        return base64.b64encode(cls.key.encrypt(
            data.encode(),
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        ))
