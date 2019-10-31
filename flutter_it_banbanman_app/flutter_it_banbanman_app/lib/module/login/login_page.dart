import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/login/login_form.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 登入頁面
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
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
                      Future.delayed(Duration(microseconds: 500), () async {
                        try {
                          gitHubClient = getGithubClient(
                            useName: state.userNameController.text,
                            password: state.passwordController.text,
                            /**token: DotEnv().env["GITHUB_TOKEN"]*/
                          );

                          await gitHubClient.users.getCurrentUser();

                          Fluttertoast.showToast(msg: "Login Success!");

                          Navigator.pushReplacementNamed(
                              context, RoutesTable.home);
                        } catch (e) {
                          Fluttertoast.showToast(msg: "Login Failure ($e)!");
                          print('[Tony] login error:$e');
                        } finally {
                          progress.dismiss();
                        }
                      });
                    }
                  },
                ))));
  }
}
