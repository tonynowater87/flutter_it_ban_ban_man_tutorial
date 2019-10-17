import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrendingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[Tab(text: "Project"), Tab(text: "Developer")],
            ),
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(child: Text("Language: All")),
                    PopupMenuItem(child: Text("Date range: daily")),
                  ];
                },
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              TrendingProject(),
              TrendingDeveloper(),
            ],
          ),
        ));
  }
}

class TrendingProject extends StatelessWidget {
  final trendingProject = [];

  TrendingProject({Key key}) : super(key: key) {
    final circleAvatar = {
      "username": "PavelDoGreat",
      "href": "https://github.com/PavelDoGreat",
      "avatar": "https://avatars2.githubusercontent.com/u/24439787"
    };

    final project1 = {
      "title": "google / flutter",
      "subTitle": "multi platform",
      "trailing": "Dart",
      "starts": 5566,
      "builtBy": [
        circleAvatar,
      ]
    };

    final project2 = {
      "title": "google / flutter",
      "subTitle": "multi platform",
      "trailing": "Dart",
      "starts": 5566,
      "builtBy": [
        circleAvatar,
        circleAvatar,
        circleAvatar,
        circleAvatar,
        circleAvatar,
      ]
    };

    trendingProject.add(project1);
    trendingProject.add(project2);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {});
        },
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(trendingProject[index]["title"]),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.0),
                      Text(trendingProject[index]["subTitle"]),
                      SizedBox(height: 4.0),
                      Row(
                        children: <Widget>[
                          Text("★ ${trendingProject[index]['starts']}"),
                          // ignore: sdk_version_ui_as_code
                          ...buildList(trendingProject[index]["builtBy"])
                        ],
                      )
                    ]),
                trailing: Text(trendingProject[index]["trailing"]),
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: 0);
            },
            itemCount: trendingProject.length));
  }

  List<Padding> buildList(List buildByList) {
    print('[Tony] $buildByList');
    List circleAvatars = buildByList.map((buildBy) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 12.0,
          backgroundImage: NetworkImage(buildBy["avatar"]),
        ),
      );
    }).toList(growable: false);

    if (circleAvatars.length > 3) {
      return circleAvatars.sublist(0, 3);
    } else {
      return circleAvatars;
    }
  }
}

class TrendingDeveloper extends StatelessWidget {
  final List developers = [
    {
      "username": "lirantal",
      "name": "Liran Tal",
      "type": "user",
      "url": "https://github.com/lirantal",
      "avatar": "https://avatars2.githubusercontent.com/u/316371",
      "repo": {
        "name": "dockly",
        "description":
            "Immersive terminal interface for managing docker containers and services",
        "url": "https://github.com/lirantal/dockly"
      }
    },
    {
      "username": "wojtekmaj",
      "name": "Wojciech Maj",
      "type": "user",
      "url": "https://github.com/wojtekmaj",
      "avatar": "https://avatars0.githubusercontent.com/u/5426427",
      "repo": {
        "name": "react-pdf",
        "description":
            "Display PDFs in your React app as easily as if they were images.",
        "url": "https://github.com/wojtekmaj/react-pdf"
      }
    },
    {
      "username": "mrdoob",
      "name": "Mr.doob",
      "type": "user",
      "url": "https://github.com/mrdoob",
      "avatar": "https://avatars2.githubusercontent.com/u/97088",
      "repo": {
        "name": "three.js",
        "description": "JavaScript 3D library.",
        "url": "https://github.com/mrdoob/three.js"
      }
    }
  ];

  TrendingDeveloper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {});
      },
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(developers[index]["avatar"]),
              ),
              title: Row(children: [
                Text(developers[index]["name"]),
                SizedBox(width: 16),
                Text(developers[index]['username'])
              ]),
              subtitle: Text(developers[index]["repo"]["description"]),
              onTap: () {},
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0);
          },
          itemCount: developers.length),
    );
  }
}
