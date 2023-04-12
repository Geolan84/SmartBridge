from datetime import datetime
from typing import Optional
from pydantic import BaseModel

class ResumeCreate(BaseModel):
    region: int
    schedule: str
    lower_salary: int
    upper_salary: Optional[int]
    industry: str
    specialization: int
    experience_years: int
    is_disabled: bool
    employment: str
    company_type: str
    qualification: str
    about: str
    experience: str
    education: str
    phone: Optional[str]
    telegram: Optional[str]
    is_active: bool