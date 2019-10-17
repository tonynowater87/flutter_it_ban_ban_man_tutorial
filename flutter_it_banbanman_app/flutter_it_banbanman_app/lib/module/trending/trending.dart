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
              TrendingProject(),
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
    return ListView.separated(
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
              trailing: Text(trendingProject[index]["trailing"]));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: trendingProject.length);
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
