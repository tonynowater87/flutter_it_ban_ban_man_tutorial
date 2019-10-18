import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      ),
    );
  }
}
