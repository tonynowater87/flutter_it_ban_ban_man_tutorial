import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/routes.dart';

void main() => runApp(GitmeRebornApp());

class GitmeRebornApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gitmme Reborn",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        GitmeRebornRoutes.login: (context) => LoginPage(),
        GitmeRebornRoutes.home: (context) => MainPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GitmeRebornRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}

// 登入頁面
class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: Icon(Icons.people),
                    hintText: "Your Github account user name."),
              )),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Your Github account password ..."),
              )),
          SizedBox(
            width: 200,
            height: 50,
            child: FlatButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, GitmeRebornRoutes.home);
              },
              child: Text("Login"),
            ),
          )
        ],
      ),
    );
  }
}

// 主頁面
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Repo"),
              Tab(text: "Activity"),
              Tab(text: "Issues"),
            ],
          ),
        ),
      ),
    );
  }
}
