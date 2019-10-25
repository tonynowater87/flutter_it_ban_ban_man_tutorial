import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/user_tile.dart';
import 'package:github/server.dart';

class FollowingPage extends StatefulWidget {
  @override
  _FollowingPageState createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  Future<List<User>> followingUsers;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.followingUsers = fetchFollowing();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {
            this.followingUsers = fetchFollowing();
          });
        });
      },
      child: FutureBuilder(
        future: followingUsers,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("has error:${snapshot.error}"),
                );
              }
              if (!snapshot.hasData) {
                return Center(child: Text("No Data"));
              }
              return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  itemBuilder: (BuildContext context, int index) {
                    User user = snapshot.data[index];
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
                  itemCount: snapshot.data.length);
              break;
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              break;
            case ConnectionState.active:
              break;
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<User>> fetchFollowing() async {
    final user = await gitHubClient.users.getCurrentUser();
    final List followingResult = await gitHubClient.getJSON("/users/${user.login}/following");
    List<User> followingUsers = followingResult.map((user) {
      return User.fromJson(user);
    }).toList();
    return followingUsers;
  }
}
