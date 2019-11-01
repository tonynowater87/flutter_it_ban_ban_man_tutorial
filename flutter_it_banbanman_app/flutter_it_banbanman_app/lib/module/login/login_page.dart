import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/model/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/preferenceRepository.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';
import 'package:flutter_it_banbanman_app/module/login/login_form.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github/server.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 登入頁面
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PreferencesRepository _sp = PreferencesRepository();

  @override
  Widget build(BuildContext context) {

    _logSp();

    return ProgressHUD(
        child: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Container(
                    alignment: Alignment.centerLeft,
                    child: Text("登入"),
                  ),
                ),
                body: LoginFormWidget(
                  onLogin: (state) {
                    if (state.formKey.currentState.validate()) {
                      final progress = ProgressHUD.of(context);
                      progress.showWithText("Loading...");
                      FocusScope.of(context).unfocus(); // dismiss the keyboard
                      _login(context, state.userNameController.text,
                          state.passwordController.text, () {
                        print('[Tony] login callback');
                        progress.dismiss();
                      });
                    }
                  },
                ))));
  }

  void _login(BuildContext context, String userName, String userPwd,
      Function() callback) {
    Future.delayed(Duration(microseconds: 500), () async {
      try {
        gitHubClient = getGithubClient(
          useName: userName,
          password: userPwd,
          /*token: DotEnv().env["GITHUB_TOKEN"]*/
        );

        await gitHubClient.users.getCurrentUser();

        Fluttertoast.showToast(msg: "Login Success!");

        Navigator.pushReplacementNamed(context, RoutesTable.home);
      } catch (e) {
        Fluttertoast.showToast(msg: "Login Failure ($e)!");
        print('[Tony] login error:$e');
      } finally {
        callback();
      }
    });
  }

  void _logSp() async {
    var userName = await _sp.getUserName();
    var userPwd = await _sp.getUserPwd();
    var autoLogin = await _sp.getAutoLogin();
    print('[Tony] build login page:$userName, $userPwd, $autoLogin');

    if (autoLogin) {
      showToast("auto login ...");
      _login(context, userName, userPwd, () {});
    }
  }
}
