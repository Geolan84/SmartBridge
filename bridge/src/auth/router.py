from fastapi import APIRouter, status, Depends, HTTPException
from fastapi.responses import Response
from manager import create_access_token, create_email_renew_token, check_validity
from database import get_async_session
from auth.auth_repository import AuthRepository as auth
from auth.schemas import UserLogin, UserRegister
from mail.mail_service import MailSender


router = APIRouter(
    prefix="/auth",
    tags=["Auth"]
)

@router.post("/login")
async def login(user_log: UserLogin, session=Depends(get_async_session)):
    try:
        user = await auth.get_user_db(user_log.email, user_log.password, session)
    except Exception:
        raise HTTPException(
            status_code=400,
        )

    if user is None:
        raise HTTPException(
            status_code=400,
            detail="LOGIN_BAD_CREDENTIALS"
        )
    data = {
        'user_id': user[0],
        'is_hr': user[-3],
    }
    token = create_access_token(data=data)
    return {'token': token, 'is_hr': user[-3], 'user_id': user[0]}

@router.post("/forgot")
async def renew_password(email: str, session=Depends(get_async_session)):
    try:
        if await auth.check_email(email, session):
            data = {"email": email}
            token = create_email_renew_token(data)
            #Отправка письма.
            if MailSender.send_recover_link(email, token):
                return Response(status_code=200)
        else:
            raise HTTPException(status_code=400)
    except:
        raise HTTPException(status_code=400)

@router.get("/recover")
async def recover_password(link: str, session=Depends(get_async_session)):
    try:
        email = check_validity(link)
    except:
        raise HTTPException(status_code=400)
    if email is None:
        raise HTTPException(status_code=400, detail="Email doesn't exist.")
    try:
        new_password = auth.generate_password()
        await auth.update_user_password(email, auth.hash_password(new_password), session)
        MailSender.send_new_password(email, new_password)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    return Response(status_code=200)

@router.post("/register")
async def register(user_reg: UserRegister, session=Depends(get_async_session)):
    #try:
    print(user_reg)
    await auth.signup(user_reg, session)
    # except Exception as e:
    #     print(e)
    #     raise HTTPException(
    #         status_code=500,
    #     )
    return Response(status_code=201)