from typing import Optional
from pydantic import BaseModel

class UserLogin(BaseModel):
    email: str
    password: str

class UserRegister(BaseModel):
    email: str
    hashed_password: str
    first_name: str
    second_name: str
    patronymic: Optional[str]
    birthday: str
    is_hr: bool