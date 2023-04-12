from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, insert, update, delete
from auth.schemas import UserRegister
from models import user
from datetime import datetime


class ProfileRepository:

    @staticmethod
    async def get_account(user_id: int, session: AsyncSession):
        query = select(user).where(user.c.user_id == user_id)
        result = await session.execute(query)
        return result.all()
    
    @staticmethod
    async def delete_profile(user_id: int, session: AsyncSession):
        stmt = delete(user).where(user.c.user_id == user_id)
        await session.execute(stmt)
        await session.commit()

