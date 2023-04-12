from decouple import config

DB_USER = config("DB_USER")
DB_PASS = config("DB_PASS")
DB_NAME = config("DB_NAME")
DB_PORT = config("DB_PORT")
DB_HOST = config("DB_HOST")
SECRET = config("SECRET")
ALGORITHM = config("ALGORITHM")
MAIL_KEY = config("MAIL_KEY")
EMAIL_SENDER = config("EMAIL_SENDER")