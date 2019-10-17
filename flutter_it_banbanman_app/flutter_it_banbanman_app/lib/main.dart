import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/profile/profile.dart';
import 'package:flutter_it_banbanman_app/module/trending/trending.dart';
import 'package:flutter_it_banbanman_app/routes.dart';

import 'module/login/login_page.dart';
import 'module/search/search_delegate.dart';

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
        RoutesTable.profile: (context) => ProfilePage(),
        RoutesTable.trending: (context) => TrendingPage(),
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                accountName: Text("Tony"),
                accountEmail: Text("Tony@gmail.com"),
                currentAccountPicture: IconButton(
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://avatars0.githubusercontent.com/u/26626322?s=40&v=4"),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesTable.profile);
                  },
                ),
                otherAccountsPictures: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                ],
              ),
              DrawerTitle(
                iconData: Icons.trending_up,
                text: "趨勢",
                onPressed: () {
                  Navigator.pushNamed(context, RoutesTable.trending);
                },
              ),
              DrawerTitle(
                iconData: Icons.settings,
                text: "設定",
              ),
              DrawerTitle(
                iconData: Icons.info,
                text: "關於",
              ),
              DrawerTitle(
                iconData: Icons.power_settings_new,
                text: "登出",
                onPressed: () async {
                  await showDialog(
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
                          ));
                },
              )
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
    return RefreshIndicator(
      onRefresh: () {},
      child: Container(
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
      ),
    );
  }
}

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
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
    return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              setState(() {
                var obj = {
                  "title": "refresh new item",
                  "description": "\n\n★ 3",
                  "lang": "● Kotlin"
                };
                repoList.add(obj);
                repoList.add(obj);
                repoList.add(obj);
              });
            });
          },
          child: Container(
            child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) =>
                    ListTile(
                      title: Text(repoList[index]["title"]),
                      subtitle: Text(repoList[index]["description"]),
                      trailing: Text(repoList[index]["lang"]),
                      isThreeLine: false,
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      onTap: () {},
                    ),
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(
                      height: 0,
                      color: Colors.grey,
                    ),
                itemCount: repoList.length),
          ),
        );
  }
}

class DrawerTitle extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function onPressed;

  const DrawerTitle({Key key, this.iconData, this.text = "", this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[Icon(iconData), SizedBox(width: 24.0), Text(text)],
      ),
      onTap: onPressed ?? () {
        print('[Tony] "not set onPressed"');
      },
    );
  }
}
