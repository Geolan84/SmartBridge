from fastapi import FastAPI
import uvicorn

from resume.router import router as router_resume
from auth.router import router as auth_router
from profiler.router import router as prof_router
from messages.router import router as message_router

import logging
from fastapi import FastAPI, Request, status
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse


app = FastAPI(title="Smartbridge")


@app.get("/")
def read_root():
    return "Hello from SmartBridge API Server."

app.include_router(
    router=auth_router,
)

app.include_router(
    router=prof_router,
)

app.include_router(
    router=router_resume
)

app.include_router(
     router=message_router
)

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
	exc_str = f'{exc}'.replace('\n', ' ').replace('   ', ' ')
	logging.error(f"{request}: {exc_str}")
	content = {'status_code': 10422, 'message': exc_str, 'data': None}
	return JSONResponse(content=content, status_code=status.HTTP_422_UNPROCESSABLE_ENTITY)

# if __name__ == "__main__":
#     uvicorn.run("main:app", host="0.0.0.0", port=8080, log_level="info", reload=True)