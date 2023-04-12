bool validateEmail(String email) {
  int firstAtSign = email.indexOf("@");
  int lastAtSign = email.lastIndexOf("@");
  int dot = email.lastIndexOf(".");
  return firstAtSign != -1 &&
      firstAtSign == lastAtSign &&
      dot > firstAtSign &&
      dot != email.length - 1 &&
      dot != 0 &&
      !email.contains(" ") &&
      email[lastAtSign + 1] != ".";
}

bool validatePassword(String password) {
  return password.length < 51 &&
      password.length > 5 &&
      !password.contains(' ');
}