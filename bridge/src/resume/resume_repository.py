from sqlalchemy import insert, select
from models import resume, region, specialization, favorites
from datetime import datetime

from sqlalchemy.ext.asyncio import AsyncSession
from resume.schemas import ResumeCreate, ResumeSearch

class ResumeRepository:
    @staticmethod
    async def new_resume(user_id: int, resume_reg: ResumeCreate, session: AsyncSession):  
        data = resume_reg.dict()
        data['user_id'] = user_id
        data['updated_at'] = datetime.now()
        stmt = insert(resume).values(**data)
        await session.execute(stmt)
        await session.commit()

    @staticmethod
    async def get_resumes(user_id: int, session: AsyncSession):
        query = select(resume.join(region, resume.c.region == region.c.geo_id).join(specialization, resume.c.specialization == specialization.c.spec_id)).where(resume.c.user_id == user_id)
        result = await session.execute(query)
        return result.all()
    
    @staticmethod
    async def get_resume(resume_id: int, session: AsyncSession):
        query = select(resume.join(region, resume.c.region == region.c.geo_id).join(specialization, resume.c.specialization == specialization.c.spec_id)).where(resume.c.resume_id == resume_id)
        result = await session.execute(query)
        return result.first()
    
    @staticmethod
    async def delete_resume(resume_id: int, session: AsyncSession):
        pass
    
    @staticmethod
    async def search_ankets(session: AsyncSession):
       query = select(resume.join(region, resume.c.region == region.c.geo_id).join(specialization, resume.c.specialization == specialization.c.spec_id))
       result = await session.execute(query)
       return result.all()
    
    @staticmethod
    async def get_all_favorites(hr_id: int, session: AsyncSession):
        query = select(resume.join(region, resume.c.region == region.c.geo_id).join(specialization, resume.c.specialization == specialization.c.spec_id).join(favorites, resume.c.resume_id == favorites.c.favorite_id and favorites.c.hr_id == hr_id))#.where(resume.c.hr_id == hr_id)
        result = await session.execute(query)
        return result.all()
    
    @staticmethod
    async def add_favorite(hr_id: int, resume_id: int, session: AsyncSession):
        stmt = insert(favorites).values(**{"hr_id": hr_id, "favorite_id": resume_id})
        await session.execute(stmt)
        await session.commit()

    