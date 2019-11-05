import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';

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

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('[Tony] SplashPage Animation completed');
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
    return FadeTransition(
        opacity: _animation,
        child: Scaffold(
            body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
              Hero(
                  tag: 'splash-image',
                  child: Image.asset("assets/images/login_sign.png", width: 300, height: 200)),
              Text('Gitmme Reborn', style: Theme.of(context).textTheme.display1, textAlign: TextAlign.center)
            ]))));
  }
}
