import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';
import 'package:flutter_it_banbanman_app/module/login/bloc/bloc.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    this._animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    this._animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    init();
  }

  void init() async {
    bool autoLogin = await PreferencesRepository().getAutoLogin();
    String userName = await PreferencesRepository().getUserName();
    String password = await PreferencesRepository().getUserPwd();

    _animationController.addStatusListener((status) {
      var isAutoLogin = autoLogin && userName.isNotEmpty && password.isNotEmpty;
      if (isAutoLogin) {
        _autoLogin(userName, password);
      } else if (!isAutoLogin && status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, RoutesTable.login);
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print('[Tony] Splash state:${state.isLoginSuccess}');
        if (state.isLoginSuccess) {
          Provider.of<AccountModel>(context).updateUser(state.user);
          Navigator.pushReplacementNamed(context, RoutesTable.main);
        }
      },
      child: FadeTransition(
          opacity: _animation,
          child: Scaffold(
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                Hero(
                    tag: 'splash-image',
                    child: Image.asset("assets/images/login_sign.png",
                        width: 300, height: 200)),
                Text('Gitmme Reborn',
                    style: Theme.of(context).textTheme.display1,
                    textAlign: TextAlign.center)
              ])))),
    );
  }

  void _autoLogin(String userName, String password) {
    print('[Tony] auto login:$userName, $password');
    showToast(S.of(context).login_loading);
    BlocProvider.of<LoginBloc>(context)
        .dispatch(ClickLoginButton(userName: userName, password: password));
  }
}
