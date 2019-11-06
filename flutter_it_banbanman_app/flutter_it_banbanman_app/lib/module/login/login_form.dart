import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({Key key}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  FocusNode _passwordFocusNode = FocusNode();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  LoginBloc _loginBloc;
  bool _isHidden = true;
  bool _isAutoLogin = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _userNameController.addListener(_onUserNameChanged);
    _passwordController.addListener(_onPasswordChanged);
    PreferencesRepository().getAutoLogin().then((value) {
      setState(() {
        _isAutoLogin = value;
      });
    });
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Hero(
                      tag: 'splash-image',
                      child: Image.asset(
                        "assets/images/login_sign.png",
                        width: 200,
                        height: 100,
                      )),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _userNameController,
                    decoration: InputDecoration(
                        labelText: S.of(context).login_username,
                        prefixIcon: Icon(Icons.people),
                        hintText: S.of(context).login_username_hint),
                    autovalidate: true,
                    validator: (_) {
                      return state.isUserNameValid
                          ? null
                          : S.of(context).login_username_error_msg;
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                      labelText: S.of(context).login_password,
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: _isHidden
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: _toggleVisibility),
                      hintText: S.of(context).login_password_hint,
                    ),
                    autovalidate: true,
                    validator: (_) {
                      return state.isPasswordValid
                          ? null
                          : S.of(context).login_password_error_msg;
                    },
                    onFieldSubmitted: (value) {},
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.black12,
                    child: FlatButton(
                      child: Text(S.of(context).login),
                      onPressed: isButtonEnable(state) ? _submitLogin : null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(S.of(context).login_auto_login),
                      Checkbox(
                        value: _isAutoLogin,
                        onChanged: (value) {
                          setState(() {
                            _isAutoLogin = !_isAutoLogin;
                            print('[Tony] _isAutoLogin:$_isAutoLogin');
                            PreferencesRepository().setAutoLogin(_isAutoLogin);
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitLogin() {
    _loginBloc.dispatch(new ClickLoginButton(
        userName: _userNameController.text,
        password: _passwordController.text));
  }

  void _onUserNameChanged() {
    _loginBloc.dispatch(UsernameChange(userName: _userNameController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.dispatch(PasswordChange(password: _passwordController.text));
  }

  bool isButtonEnable(LoginState state) =>
      state.isSubmitValid &&
      _userNameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;
}
