from sqlalchemy import MetaData, Table, Column, Integer, String, TIMESTAMP, Boolean, ForeignKey, Enum
from datetime import datetime
from database import Base
from datetime import datetime

metadata = MetaData()

user = Table(
    "users",
    metadata,
    Column("user_id", Integer, primary_key=True),
    Column("email", String, nullable=False, unique=True),
    Column("hashed_password", String, nullable=False),
    Column("first_name", String, nullable=False),
    Column("second_name", String, nullable=False),
    Column("patronymic", String),
    Column("birthday", TIMESTAMP, nullable=False),
    Column("is_hr", Boolean, default=False),
    Column("registered_at", TIMESTAMP, default=datetime.utcnow),
    Column("is_verified", Boolean, default=False, nullable=False)
)

# Город проживания.
region = Table(
    "region",
    metadata,
    Column("geo_id", Integer, primary_key=True, autoincrement=True),
    Column("geoname", String(100), nullable=False)
)

# Ключевые навыки.
know_skills = Table(
    "know_skills",
    metadata,
    Column("resume", Integer, ForeignKey("resume.resume_id", ondelete='CASCADE')),
    Column("skill", Integer, ForeignKey("skills.skill_id"))
)

# Специализация
specialization = Table(
    "specialization",
    metadata,
    Column("spec_id", Integer, primary_key=True, autoincrement=True),
    Column("spec_name", String, nullable=False)
)

# Skills
skills = Table(
    "skills",
    metadata,
    Column("skill_id", Integer, primary_key=True, autoincrement=True),
    Column("skill_name", String, nullable=False)
)

favorites = Table(
    "favorites",
    metadata,
    Column("hr_id", Integer, ForeignKey("users.user_id", ondelete='CASCADE'), nullable=False),
    Column("favorite_id", Integer, ForeignKey("resume.resume_id", ondelete='CASCADE'), nullable=False)
)

message_templates = Table(
    "msg_templates",
    metadata,
    Column("template_id", Integer, primary_key=True, autoincrement=True),
    Column("hr_id", Integer, ForeignKey("users.user_id", ondelete='CASCADE'), nullable=False),
    Column("title", String, nullable=False),
    Column("body", String, nullable=False)
)

# Анкета.
resume = Table(
    "resume",
    metadata,
    Column("resume_id", Integer, primary_key=True, autoincrement=True),
    Column("user_id", Integer, ForeignKey("users.user_id", ondelete='CASCADE'), nullable=False),
    Column("region", Integer, ForeignKey("region.geo_id"), nullable=False),
    Column("schedule", Enum('full time', 'epoch', 'flexible', 'part-time', 'remote', 'shift', name="schedule_enum", create_type = False)),
    Column("lower_salary", Integer),
    Column("upper_salary", Integer),
    Column("industry", Enum('IT','Finance','Electronics','Industrial','Telecommunications','Business','Education',\
                            name="industry_enum", create_type=False), nullable=False),
    Column("specialization", Integer, ForeignKey("specialization.spec_id"), nullable=False),
    Column("experience_years", Integer, nullable=False),
    Column("is_disabled", Boolean, default=False),
    Column("employment", Enum('full', 'partial', 'internship', name="emloyment_enum", create_type=False)),
    Column("company_type", Enum('startup','gov','accredited','commercialized', name="company_enum", create_type=False)),
    Column("qualification", Enum('intern','junior','middle','senior','lead', name="qual_enum", create_type = False), nullable=False),
    Column("about", String, nullable=False),
    Column("experience", String, nullable=False),
    Column("education", String, nullable=False),
    Column("phone", String),
    Column("telegram", String),
    Column("is_active", Boolean, default=True, nullable=False),
    Column("updated_at", TIMESTAMP, default=datetime.utcnow),
)