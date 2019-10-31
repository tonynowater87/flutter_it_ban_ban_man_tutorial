import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {

  final Function(_LoginFormWidgetState state) onLogin;

  LoginFormWidget({Key key, this.onLogin}) : super(key: key);

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  FocusNode _passwordFocusNode = FocusNode();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
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
                  return "Please enter your user name";
                } else {
                  return null;
                }
              },
              controller: userNameController,
              decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.people),
                  hintText: "Your Github account user name."),
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
                  return "Please enter your password";
                } else {
                  return null;
                }
              },
              focusNode: _passwordFocusNode,
              controller: passwordController,
              obscureText: _isHidden,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: _isHidden
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: _toggleVisibility),
                hintText: "Your Github account password ...",
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
              margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
              color: Colors.black12,
              child: FlatButton(
                child: Text(
                  "登入",
                ),
                textColor: Colors.white,
                color: Colors.blueGrey,
                onPressed: () {
                  widget.onLogin(this);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
