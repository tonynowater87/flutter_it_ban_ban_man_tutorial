class Validators {
  static final RegExp _userNameRegExp = RegExp(
    r'^[A-Za-z\d]{4,14}$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidUserName(String userName) {
    return _userNameRegExp.hasMatch(userName);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }
}