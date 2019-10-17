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
              Text("Repo"),
              Text("User"),
            ],
          ),
        ));
  }
}

