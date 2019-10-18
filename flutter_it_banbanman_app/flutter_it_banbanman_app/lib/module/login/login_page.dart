import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_it_banbanman_app/routes.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

// 登入頁面
class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      print('[Tony] _toggleVisibility:$_isHidden');
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _primaryTextTheme = Theme.of(context).primaryTextTheme;

    return ProgressHUD(
        child: Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text("登入"),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: Image.asset("assets/images/login_sign.png"),
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.people),
                      hintText: "Your Github account user name."),
                )),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
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
                child: Text("登入", style: _primaryTextTheme.button,),
                textColor: Colors.white,
                color: Colors.blueGrey,
                onPressed: () {
                  final progress = ProgressHUD.of(context);
                  progress.showWithText("Loading...");
                  FocusScope.of(context).unfocus(); // dismiss the keyboard
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushReplacementNamed(context, RoutesTable.home);
                    progress.dismiss();
                  });
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
