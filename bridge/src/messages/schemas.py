from pydantic import BaseModel

class TemplateCreate(BaseModel):
    title: str
    body: str