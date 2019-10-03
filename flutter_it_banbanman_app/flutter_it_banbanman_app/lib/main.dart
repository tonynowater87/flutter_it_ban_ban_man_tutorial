import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/login/LoginPage.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                accountName: Text("Tony"),
                accountEmail: Text("Tony@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://avatars0.githubusercontent.com/u/26626322?s=40&v=4"),
                ),
                otherAccountsPictures: <Widget>[Icon(Icons.edit, color: Colors.white,)],
              ),
              FlatButton(
                  child: Text("Log out"),
                  onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            content: Text("確定登出?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("取消"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text("確定"),
                                onPressed: () =>
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesTable.login,
                                        ModalRoute.withName(RoutesTable.login)),
                              )
                            ],
                          )))
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            RepoPage(),
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
            trailing: Icon(Icons.arrow_forward_ios),
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
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => {},
          ),
        ],
      ),
    );
  }
}

class RepoPage extends StatelessWidget {
  final repoList = [
    {
      "title": "BbsonLin/gitme_reborn",
      "description": "No description provided.\n\n★ 0",
      "lang": "● Dart"
    },
    {
      "title": "BbsonLin/ithome-ironman",
      "description": "No description provided.\n\n★ 0",
      "lang": ""
    },
    {
      "title": "BbsonLin/flask-request-logger",
      "description": "",
      "lang": "● Python"
    },
    {
      "title": "BbsonLin/flask-request-logger",
      "description":
          "A Flask extension for recording requests and responses into database\n\n★ 3",
      "lang": "● Python"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(repoList[index]["title"]),
                subtitle: Text(repoList[index]["description"]),
                trailing: Text(repoList[index]["lang"]),
                isThreeLine: false,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                onTap: () {},
              ),
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: 0,
                color: Colors.grey,
              ),
          itemCount: repoList.length),
    );
  }
}
