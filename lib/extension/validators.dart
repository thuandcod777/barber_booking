class Validators {
  static final _emailRegExp = RegExp(
    r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$',
  );
  static final _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}
