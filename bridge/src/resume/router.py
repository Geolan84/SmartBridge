from fastapi import APIRouter, Depends, HTTPException, Security
from fastapi.responses import Response
from sqlalchemy.ext.asyncio import AsyncSession
from database import get_async_session
from resume.schemas import ResumeCreate
from fastapi.security import HTTPAuthorizationCredentials
from resume.resume_repository import ResumeRepository #new_resume, get_resumes
from manager import read_token, bearer
import json

router = APIRouter(
    prefix="/work",
    tags=["Resume"]
)


@router.get("/resumes")
async def get_all_resumes(session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized. Use /auth/login endpoint."
        )
    if info[1]:
        raise HTTPException(
            status_code=403,
            detail="You haven't rights to get all resume"
        )
    try:
        result = await ResumeRepository.get_resumes(info[0], session)
        #print(result)
        return {"resumes": [x._mapping for x in result]}
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    

@router.post("/resume")
async def create_resume(resume_data: ResumeCreate, session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized"
        )
    if info[1]:
        raise HTTPException(
            status_code=403,
            detail="You haven't rights to create resume"
        )
    try:
        await ResumeRepository.new_resume(info[0], resume_data, session)
        return Response(status_code=201)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    

@router.get("/resume/{resume_id}")
async def get_resume_route(resume_id: int, session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized"
        )
    try:
        result = await ResumeRepository.get_resume(resume_id, session)
        if result is None:
            raise HTTPException(status_code=404)
        return {"resume": result._mapping}
        #await ResumeRepository.new_resume(info[0], resume_data, session)
        #return Response(status_code=201)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    
@router.patch("/resume/{resume_id}")
async def update_resume(resume_id: int):
    pass

@router.delete("/resume/{resume_id}")
async def update_resume(resume_id: int):
    pass

@router.get("/template")
async def get_template():
    pass

@router.post("/template")
async def post_template():
    pass

@router.delete("/template/{template_id}")
async def delete_template():
    pass

@router.patch("/template/{template_id}")
async def delete_template():
    pass

@router.get("/favorite")
async def get_favorites():
    pass

@router.delete("/favorite/{resume_id}")
async def delete_favorite():
    pass

@router.post("/favorite/{resume_id}")
async def add_favorite():
    pass