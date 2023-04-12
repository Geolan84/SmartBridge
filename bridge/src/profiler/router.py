from fastapi import APIRouter, Depends, HTTPException, Security, File, UploadFile
from fastapi.responses import Response, FileResponse
from sqlalchemy.ext.asyncio import AsyncSession
from database import get_async_session
from fastapi.security import HTTPAuthorizationCredentials
from profiler.profile_repository import ProfileRepository
from manager import read_token, bearer
import os.path

router = APIRouter(
    prefix="/profile",
    tags=["Profile"]
)

@router.delete("/{user_id}")
async def delete_profile(user_id: int, session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
    info = read_token(token)
    if info is None:
        raise HTTPException(
            status_code=401,
            detail="Not authorized. Use /auth/login endpoint."
        )
    try:
        check = ProfileRepository.get_account(user_id, session)
        if check is None or check == []:
            raise HTTPException(status_code=404)
        
        await ProfileRepository.delete_profile(user_id, session)
        return Response(status_code=200)
        #raise HTTPException(status_code=412)
    except Exception as e:
        print(type(e))
        raise HTTPException(status_code=400)
    
@router.post("/photo/{user_id}")
async def add_photo(user_id: int, file: UploadFile, token: HTTPAuthorizationCredentials = Security(bearer)):
    try:
        with open(file.filename, 'wb') as image:
            content = await file.read()
            image.write(content)
            image.close()
    except Exception as e:
        print(e)
        raise HTTPException(status_code=300)
    
@router.get("/photo/{user_id}")
async def download_file(user_id: int):#, token: HTTPAuthorizationCredentials = Security(bearer)):
  if os.path.isfile(f'photo{user_id}.jpg'):
    return FileResponse(path=f'photo{user_id}.jpg', filename=f'avatar.jpg', media_type='multipart/form-data')
  
@router.patch("/{user_id}")
async def update_profile(user_id: int):
    pass

# @router.update("/{user_id}")
# async def get_profile(session: AsyncSession = Depends(get_async_session), token: HTTPAuthorizationCredentials = Security(bearer)):
#     info = read_token(token)
#     if info is None:
#         raise HTTPException(
#             status_code=401,
#             detail="Not authorized. Use /auth/login endpoint."
#         )
#     try:
#         result = await ProfileRepository.get_account(info[0], session)
#         return {"accounts": result}
#     except Exception:
#         raise HTTPException(status_code=400)

# @router.post("/update")
# async def register(user_reg: UserRegister, session=Depends(get_async_session)):
    


