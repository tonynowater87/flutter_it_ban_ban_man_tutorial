import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_it_banbanman_app/model/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';
import 'package:flutter_it_banbanman_app/module/login/bloc/validator.dart';

import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is UsernameChange) {
      yield* _userNameChange(event.userName);
    } else if (event is PasswordChange) {
      yield* _passwordChange(event.password);
    } else if (event is ClickLoginButton) {
      yield* _clickLoginButton(event.userName, event.password);
    }
  }

  Stream<LoginState> _userNameChange(String userName) async* {
    var validUserName = Validators.isValidUserName(userName);
    print('[Tony] validUserName:$userName $validUserName');
    yield currentState.update(isUserNameValid: validUserName);
  }

  Stream<LoginState> _passwordChange(String password) async* {
    var validPassword = Validators.isValidPassword(password);
    print('[Tony] validUserName:$password $validPassword');
    yield currentState.update(isPasswordValid: validPassword);
  }

  Stream<LoginState> _clickLoginButton(
      String userName, String password) async* {
    yield LoginState.loading();
    try {
      gitHubClient = getGithubClient(useName: userName, password: password);
      var user = await gitHubClient.users.getCurrentUser();
      PreferencesRepository().setUserName(userName);
      PreferencesRepository().setUserPwd(password);
      yield LoginState.success(user, userName, password);
    } catch (e) {
      yield LoginState.fail(e.toString());
    }
  }
}
