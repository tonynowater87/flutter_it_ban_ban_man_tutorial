import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/main/repo.dart';
import 'package:flutter_it_banbanman_app/module/profile/follow_page.dart';
import 'package:flutter_it_banbanman_app/module/profile/profile_info.dart';


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
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250,
                  title: Text("Tony Liao"),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
                      SizedBox(
                        height: 48.0,
                      )
                    ],
                  )),
                  bottom: TabBar(
                    labelPadding: EdgeInsets.zero,
                    tabs: <Widget>[
                      Tab(text: "Repos"),
                      Tab(text: "Starts"),
                      Tab(text: "Followers"),
                      Tab(text: "Following"),
                    ],
                  ),
                )
              ];
            },
            body: TabBarView(
              children: <Widget>[
                RepoPage(),
                RepoPage(),
                FollowPage(),
                FollowPage(),
              ],
            ),
          ),
        ),
        length: 4);
  }
}
