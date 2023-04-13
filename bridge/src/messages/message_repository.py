from sqlalchemy import insert, select, delete
from models import message_templates
from datetime import datetime

from sqlalchemy.ext.asyncio import AsyncSession
from messages.schemas import TemplateCreate

class MessageRepository:
    @staticmethod
    async def new_template(user_id: int, template_reg: TemplateCreate, session: AsyncSession):  
        data = template_reg.dict()
        data['hr_id'] = user_id
        stmt = insert(message_templates).values(**data)
        await session.execute(stmt)
        await session.commit()

    @staticmethod
    async def get_templates(hr_id: int, session: AsyncSession):
        query = select(message_templates).where(message_templates.c.hr_id == hr_id)
        result = await session.execute(query)
        return result.all()
    
    @staticmethod
    async def get_template(hr_id: int, session: AsyncSession):
        query = select(message_templates).where(message_templates.c.hr_id == hr_id)
        result = await session.execute(query)
        return result.first()
    
    @staticmethod
    async def remove_template(template_id, session: AsyncSession):
        stmt = delete(message_templates).where(message_templates.c.template_id == template_id)
        await session.execute(stmt)
        await session.commit()