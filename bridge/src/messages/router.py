from fastapi import APIRouter, Depends, HTTPException, Security
from fastapi.responses import Response
from sqlalchemy.ext.asyncio import AsyncSession
from database import get_async_session
from messages.schemas import TemplateCreate
from fastapi.security import HTTPAuthorizationCredentials
from messages.message_repository import MessageRepository
from manager import read_token, bearer

router = APIRouter(
    prefix="/chat",
    tags=["Chat"]
)


@router.get("/template")
async def get_all_templates(session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized. Use /auth/login endpoint."
        )
    if not info[1]:
        raise HTTPException(
            status_code=403,
            detail="You haven't rights to get all templates"
        )
    try:
        result = await MessageRepository.get_templates(info[0], session)
        return {"templates": [x._mapping for x in result]}
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    

@router.post("/template")
async def create_resume(template_data: TemplateCreate, session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized"
        )
    if not info[1]:
        raise HTTPException(
            status_code=403,
            detail="You haven't rights to create template"
        )
    try:
        await MessageRepository.new_template(info[0], template_data, session)
        return Response(status_code=201)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    

@router.get("/template/{template_id}")
async def get_resume_route(template_id: int, session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized"
        )
    try:
        result = await MessageRepository.get_template(template_id, session)
        if result is None:
            raise HTTPException(status_code=404)
        return {"resume": result._mapping}

    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    
@router.delete("/template/{template_id}")
async def annigilate_template(template_id: int, session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized"
        )
    if not info[1]:
        raise HTTPException(
            status_code=403,
            detail="You haven't rights to delete template"
        )
    try:
        await MessageRepository.remove_template(template_id, session)
        return Response(status_code=200)
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400)
    
# @router.patch("/resume/{resume_id}")
# async def update_resume(resume_id: int):
#     pass

# @router.delete("/resume/{resume_id}")
# async def update_resume(resume_id: int):
#     pass

# @router.get("/template")
# async def get_template():
#     pass

# @router.post("/template")
# async def post_template():
#     pass

# @router.delete("/template/{template_id}")
# async def delete_template():
#     pass

# @router.patch("/template/{template_id}")
# async def delete_template():
#     pass

# @router.get("/favorite")
# async def get_favorites():
#     pass

# @router.delete("/favorite/{resume_id}")
# async def delete_favorite():
#     pass

# @router.post("/favorite/{resume_id}")
# async def add_favorite():
#     pass