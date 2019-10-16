import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String bio;
  final String location;

  ProfilePage(
      {Key key,
      @required this.imageUrl,
      @required this.name,
      this.bio,
      this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            title: Text("Tony Liao"),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), onPressed: () {
                Navigator.pop(context);
            },),
            flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ProfileInfo(
                      avatarUrl:
                          "https://avatars3.githubusercontent.com/u/9815472?s=460&v=4",
                      name: "Tony Liao",
                      location: "Taichung, Taiwan",
                    ),
                    SizedBox(height: 8.0),
                    TabBar(
                      tabs: <Widget>[
                        Tab(text: "Repos"),
                        Tab(text: "Starts"),
                        Tab(text: "Followers"),
                        Tab(text: "Following"),
                      ],
                    )
                  ],
                )),
          ),
          SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 10)],
                      child: Text("item$index"),
                    );
                  },
                  childCount: 50,
                ),
              )),
          /*SliverFillRemaining(
            child: SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 10)],
                child: Text("item$index"),
              );
            },
            childCount: 50,
          ),
        ))*/
        ]),
      ),
      length: 4
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String location;
  final String bio;

  ProfileInfo({Key key, this.avatarUrl, this.name, this.bio, this.location})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _primaryTextTheme = Theme.of(context).primaryTextTheme;
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 36.0,
          backgroundImage: NetworkImage(avatarUrl),
        ),
        SizedBox(height: 8.0),
        Text(name, style: _primaryTextTheme.subtitle),
        SizedBox(height: 6.0),
        Text(bio ?? "No bio yet", style: _primaryTextTheme.body1),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              size: _primaryTextTheme.caption.fontSize,
              color: _primaryTextTheme.caption.color,
            ),
            SizedBox(width: 4.0),
            Text(location, style: _primaryTextTheme.caption)
          ],
        ),
      ],
    );
  }
}
