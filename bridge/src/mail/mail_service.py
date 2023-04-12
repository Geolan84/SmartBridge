from config import MAIL_KEY, EMAIL_SENDER
from email.mime.text import MIMEText
import smtplib
import ssl

class MailSender:
    SMTP_PORT = 587
    SERVER = "smtp.gmail.com"

    MESSAGE_RESET = """
    <!DOCTYPE html>
    <html>
    <body>
        <h2>Сброс пароля для вашей учётной записи SmartBridge.</h2>
        <h4>Ссылка действительна в течение 24 часов!</h4>
        <a href="{0}"> Сбросить пароль </a>
        <h5>Если это не вы инициировали сброс пароля, ничего не делайте.</h5>
    </body>
    </html>
    """
    
    MESSAGE_NEW_PASSWORD = """
    <!DOCTYPE html>
    <html>
    <body>
    <h2>Новый пароль для SmartBridge.</h2>
    <h4>Ваш пароль успешно сброшен. Ваш новый пароль: {0}</h4>
    </body>
    </html>
    """

    @staticmethod
    def __send_letter(email: str, message_to_send: str):
        simple_email_context = ssl.create_default_context()

        msg = MIMEText(message_to_send,'html')
        msg['Subject'] = 'Восстановление пароля'

        try:
            TIE_server = smtplib.SMTP(MailSender.SERVER, MailSender.SMTP_PORT)
            TIE_server.starttls(context=simple_email_context)
            TIE_server.login(EMAIL_SENDER, MAIL_KEY)
            TIE_server.sendmail(EMAIL_SENDER, email, msg.as_string())
            return True
        except Exception as e:
            print(e)
            return False
        finally:
            TIE_server.quit()

    @staticmethod
    def send_recover_link(email: str, token: str) -> bool:
        return MailSender.__send_letter(email, MailSender.MESSAGE_RESET.format(f"http://localhost:8080/auth/recover?link={token}"))

    def send_new_password(email: str, new_password: str) -> bool:
        return MailSender.__send_letter(email, MailSender.MESSAGE_NEW_PASSWORD.format(new_password))

