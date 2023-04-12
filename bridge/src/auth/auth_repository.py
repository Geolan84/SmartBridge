from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, insert, update
from auth.schemas import UserRegister
from models import user
from datetime import datetime
import random
import string
import hashlib

class AuthRepository:
    @staticmethod
    async def get_user_db(email: str, password: str, session: AsyncSession):
        query = select(user).where(user.c.email == email).where(user.c.hashed_password == password)
        result = await session.execute(query)
        answer = result.all()
        if answer != []:
            return answer[0]

    @staticmethod    
    async def signup(user_reg: UserRegister, session: AsyncSession):
        data = user_reg.dict()
        birth = data['birthday']
        #data['birthday'] = datetime.fromtimestamp(float(data['birthday']))
        # "birthday":"2000-01-21 00:00:00.000Z"
        data['birthday'] = datetime.strptime(birth[:birth.find(' ')], '%Y-%m-%d')
        data['registered_at'] = datetime.now()
        print(data)
        stmt = insert(user).values(**data)
        await session.execute(stmt)
        await session.commit()

    @staticmethod
    async def check_email(email: str, session: AsyncSession):
        query = select(user).where(user.c.email == email)
        result = await session.execute(query)
        answer = result.all()
        return answer != []

    @staticmethod
    async def update_user_password(email: str, new_password: str, session: AsyncSession):
        stmt = update(user).where(user.c.email == email).values(hashed_password=new_password)
        await session.execute(stmt)
        await session.commit()

    @staticmethod
    def generate_password() -> str:
        return "".join(random.choice(string.ascii_letters) for i in range(8))
    
    @staticmethod
    def hash_password(password: str):
        return hashlib.sha224(str.encode(password)).hexdigest()
