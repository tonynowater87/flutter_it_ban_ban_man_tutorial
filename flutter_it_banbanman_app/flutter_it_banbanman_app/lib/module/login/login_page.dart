import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/login/login_form.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

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
                body: LoginFormWidget())));
  }
}
