import 'package:github/server.dart';
import 'package:meta/meta.dart';

@immutable
class LoginState {
  final bool isUserNameValid;
  final bool isPasswordValid;
  final bool isLoading;
  final User user;
  final String errorMsg;

  bool get isSubmitValid => isUserNameValid && isPasswordValid;
  bool get isLoginSuccess => user != null;
  bool get isLoginFail => errorMsg != null;

  LoginState(
      {@required this.isUserNameValid,
      @required this.isPasswordValid,
      @required this.isLoading,
      @required this.user,
      @required this.errorMsg});

  update({bool isUserNameValid, bool isPasswordValid}) {
    return _copyWith(
        isUserNameValid: isUserNameValid ?? this.isUserNameValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid);
  }

  _copyWith({bool isUserNameValid, bool isPasswordValid}) {
    return LoginState(
        isUserNameValid: isUserNameValid ?? this.isUserNameValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isLoading: false,
        user: null,
        errorMsg: null);
  }

  factory LoginState.initial() {
    return LoginState(
        isUserNameValid: true,
        isPasswordValid: true,
        isLoading: false,
        user: null,
        errorMsg: null);
  }

  factory LoginState.loading() {
    return LoginState(
        isUserNameValid: true,
        isPasswordValid: true,
        isLoading: true,
        user: null,
        errorMsg: null);
  }

  factory LoginState.fail(String errorMsg) {
    return LoginState(
        isUserNameValid: true,
        isPasswordValid: true,
        isLoading: false,
        user: null,
        errorMsg: errorMsg);
  }

  factory LoginState.success(User user, String account, String pwd) {
    return LoginState(
        isUserNameValid: true,
        isPasswordValid: true,
        isLoading: false,
        user: user,
        errorMsg: null);
  }

  @override
  String toString() {
    return '''
      isUserNameValid:$isUserNameValid
      isPasswordValid:$isPasswordValid
      isSubmitValid:${this.isSubmitValid}
      isLoginSuccess:${this.isLoginSuccess}
      isLoginFail:${this.isLoginFail}
      isLoading:${this.isLoading}
      user:$user
      errorMsg:$errorMsg
    ''';
  }
}
