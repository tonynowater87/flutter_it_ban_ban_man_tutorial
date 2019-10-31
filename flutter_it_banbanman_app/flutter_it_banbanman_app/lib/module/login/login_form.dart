import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class LoginFormWidget extends StatefulWidget {
  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset("assets/images/login_sign.png"),
            TextFormField(
              controller: _userNameController,
              decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.people),
                  hintText: "Your Github account user name."),
            ),
            SizedBox(
              height: 25,
            ),
            TextFormField(
                controller: _passwordController,
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
                )),
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
                  final progress = ProgressHUD.of(context);
                  progress.showWithText("Loading...");
                  FocusScope.of(context).unfocus(); // dismiss the keyboard
                  Future.delayed(Duration(microseconds: 500), () async {
                    try {
                      gitHubClient = getGithubClient(
                        useName: _userNameController.text,
                        password: _passwordController.text,
                        /**token: DotEnv().env["GITHUB_TOKEN"]*/
                      );

                      await gitHubClient.users.getCurrentUser();

                      Navigator.pushReplacementNamed(context, RoutesTable.home);
                    } catch (e) {
                      print('[Tony] login error:$e');
                    } finally {
                      progress.dismiss();
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
