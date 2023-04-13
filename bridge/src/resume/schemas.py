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

class ResumeSearch(BaseModel):
    region: Optional[int]
    schedule: Optional[str]
    lower_salary: Optional[int]
    upper_salary: Optional[int]
    industry: Optional[str]
    specialization: Optional[int]
    experience_years: Optional[int]
    is_disabled: Optional[bool]
    employment: Optional[str]
    company_type: Optional[str]
    qualification: Optional[str]