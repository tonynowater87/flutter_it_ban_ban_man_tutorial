import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/module/main/repo.dart';
import 'package:flutter_it_banbanman_app/module/profile/follow.dart';
import 'package:flutter_it_banbanman_app/module/profile/profile_info.dart';
import 'package:flutter_it_banbanman_app/module/profile/stars.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountModel>(context);

    return DefaultTabController(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 250,
                  title: Text(account.user.name),
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
                        avatarUrl: account.user.avatarUrl,
                        name: account.user.name,
                        bio: account.user.bio ,
                        location: account.user.location,
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
                StartsPage(),
                FollowerPage(),
                FollowingPage(),
              ],
            ),
          ),
        ),
        length: 4);
  }
}
