import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent {}

class UsernameChange extends LoginEvent {
  final String userName;

  UsernameChange({@required this.userName});
}

class PasswordChange extends LoginEvent {
  final String password;

  PasswordChange({@required this.password});
}

class ClickLoginButton extends LoginEvent {
  final String userName;
  final String password;

  ClickLoginButton({@required this.userName, @required this.password});
}
