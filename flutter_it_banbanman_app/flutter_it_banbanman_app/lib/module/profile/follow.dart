import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/user_tile.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';
import 'package:github/server.dart';
import 'package:provider/provider.dart';

class FollowingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (context, account, widget) {
        if (account.followings == null) {
          account.fetchFollowings();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await account.refreshFollowings();
              showToast("Refresh Folowings");
            },
            child: _buildFollowingView(account.followings),
          );
        }
      },
    );
  }

  _buildFollowingView(List<User> followings) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        itemBuilder: (BuildContext context, int index) {
          User user = followings[index];
          return UserTile(
            avatarUrl: user.avatarUrl,
            userName: user.login,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: followings.length);
  }
}

class FollowerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (context, account, widget) {
        if (account.followers == null) {
          account.refreshFollowers();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await account.refreshFollowers();
              showToast("Refresh Followers");
            },
            child: _buildFollowerView(account.followers),
          );
        }
      },
    );
  }

  _buildFollowerView(List<User> followers) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        itemBuilder: (BuildContext context, int index) {
          User user = followers[index];
          return UserTile(
            avatarUrl: user.avatarUrl,
            userName: user.login,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: followers.length);
  }
}
