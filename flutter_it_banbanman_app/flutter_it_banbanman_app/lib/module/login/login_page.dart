import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/model/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';
import 'package:flutter_it_banbanman_app/module/login/login_form.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:github/server.dart';
import 'package:provider/provider.dart';

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
                    child: Text(S.of(context).login),
                  ),
                ),
                body: LoginFormWidget(
                  onLogin: (state) {
                    if (state.formKey.currentState.validate()) {
                      final progress = ProgressHUD.of(context);
                      progress.showWithText(S.of(context).loading);
                      FocusScope.of(context).unfocus(); // dismiss the keyboard
                      _login(context, state.userNameController.text, state.passwordController.text, () {
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

        CurrentUser user = await gitHubClient.users.getCurrentUser();

        final account = Provider.of<AccountModel>(context);
        account.updateUser(user);

        showToast(S.of(context).login_success);

        Navigator.pushReplacementNamed(context, RoutesTable.home);
      } catch (e) {
        print('[Tony] login error:$e');
        showToast(S.of(context).login_fail(e.toString()));
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

    if (autoLogin ?? false) {
      print('[Tony] auto login ...');
      showToast(S.of(context).loading);
      _login(context, userName, userPwd, () {});
    }
  }
}
