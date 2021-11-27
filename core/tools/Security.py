import base64

from cryptography.hazmat.primitives import serialization, hashes
from cryptography.hazmat.primitives.asymmetric import padding


class Security:
    key = None

    @classmethod
    def key_is_set(cls):
        return True if cls.key is not None else False

    @classmethod
    def update_encryption_key(cls, new_key):
        if new_key is None:
            return False
        cls.key = serialization.load_pem_public_key(
            base64.b64decode(
                new_key
            )
        )
        return True

    @classmethod
    def encrypt(cls, data: str):
        if cls.key is None:
            raise ValueError("Empty key!")
        return base64.b64encode(cls.key.encrypt(
            data.encode(),
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        ))
