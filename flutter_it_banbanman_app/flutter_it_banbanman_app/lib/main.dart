import 'package:flutter/gestures.dart';
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
        RoutesTable.login: (context) => LoginPage(),
        RoutesTable.home: (context) => MainPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RoutesTable.root:
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
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
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
              onPressed: () {
                Navigator.pushReplacementNamed(context, RoutesTable.home);
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
            labelPadding: EdgeInsets.all(0),
            tabs: <Widget>[
              Tab(text: "Home"),
              Tab(text: "Repo"),
              Tab(text: "Activity"),
              Tab(text: "Issues"),
            ],
          ),
        ),
        drawer: Drawer(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                child: Text("Log out"),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, RoutesTable.login),
              )
            ],
          ),
        )),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            Text("Repo"),
            Text("Activity"),
            Text("Issues"),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              "最新",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0,
            color: Colors.blueGrey,
          ),
          ListTile(
            title: Text(
              "歡迎使用Gitme v1.1.1",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            subtitle: Text("每一位用戶都是gitme的主人!"),
            onTap: () => {},
          ),
          Divider(
            height: 0,
            thickness: 10,
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              "推薦項目",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
          ),
          Divider(
            height: 0,
            thickness: 0,
            color: Colors.blueGrey,
          ),
          ListTile(
            title: Text(
              "flukit",
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
            subtitle: Text("A Flutter UI Kit"),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}
