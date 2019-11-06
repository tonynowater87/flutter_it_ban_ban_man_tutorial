import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';
import 'package:flutter_it_banbanman_app/module/login/bloc/bloc.dart';
import 'package:flutter_it_banbanman_app/module/login/login_form.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    return ProgressHUD(
        child: BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isLoginSuccess) {
          ProgressHUD.of(context).dismiss();
          showToast(S.of(context).login_success);
          Provider.of<AccountModel>(context).updateUser(state.user);
          Navigator.pushReplacementNamed(context, RoutesTable.main);
        } else if (state.isLoginFail) {
          ProgressHUD.of(context).dismiss();
          showToast(state.errorMsg);
        } else if (state.isLoading) {
          ProgressHUD.of(context).showWithText(S.of(context).login_loading);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Container(
              alignment: Alignment.centerLeft,
              child: Text(S.of(context).login),
            ),
          ),
          body: LoginFormWidget()),
    ));
  }
}
