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
            SizedBox(
              height: 25,
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
              width: 200,
              height: 50,
              color: Colors.black12,
              child: FlatButton(
                child: Text("登入"),
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
