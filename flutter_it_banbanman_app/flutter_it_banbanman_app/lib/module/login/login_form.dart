import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';

class LoginFormWidget extends StatefulWidget {

  final Function(_LoginFormWidgetState state) onLogin;
  bool _autoLogin = false;

  LoginFormWidget({Key key, this.onLogin}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {

  FocusNode _passwordFocusNode = FocusNode();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  PreferencesRepository _sp = PreferencesRepository();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void didUpdateWidget(LoginFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sp.getAutoLogin().then((autoLogin) {
      setState(() {
        widget._autoLogin = autoLogin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset("assets/images/login_sign.png"),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return S.of(context).login_username_error_msg;
                } else {
                  return null;
                }
              },
              controller: userNameController,
              decoration: InputDecoration(
                  labelText: S.of(context).login_username,
                  prefixIcon: Icon(Icons.people),
                  hintText: S.of(context).login_username_hint),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return S.of(context).login_password_error_msg;
                } else {
                  return null;
                }
              },
              focusNode: _passwordFocusNode,
              controller: passwordController,
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
              onFieldSubmitted: (value) {
                widget.onLogin(this);
              },
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
                onPressed: () {
                  widget.onLogin(this);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(S.of(context).login_auto_login),
                Checkbox(
                  value: widget._autoLogin,
                  onChanged: (value) {
                    setState(() {
                      widget._autoLogin = !widget._autoLogin;
                      _sp.setAutoLogin(widget._autoLogin);
                      if(widget._autoLogin) {
                        _sp.setUserName(userNameController.text);
                        _sp.setUserPwd(passwordController.text);
                      }
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
