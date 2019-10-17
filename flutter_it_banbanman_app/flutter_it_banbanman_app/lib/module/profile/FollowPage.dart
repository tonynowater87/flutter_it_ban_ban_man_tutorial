import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowPage extends StatelessWidget {
  final List followers = [];

  FollowPage({Key key}) : super(key: key) {
    final follower = {
      "avatarUrl": "https://avatars1.githubusercontent.com/u/28953511?s=88&v=4",
      "name": "Koko"
    };
    followers.add(follower);
    followers.add(follower);
    followers.add(follower);
    followers.add(follower);
    followers.add(follower);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(followers[index]["avatarUrl"])),
                title: Text(followers[index]["name"]),
                trailing: ToggleButtons(
                    onPressed: (int) {
                      print('[Tony] onPress:$int');},
                    isSelected: [true, false],
                    selectedColor: Colors.green,
                    children: <Widget>[Text("Follow"), Text("UnFollow")]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(height: 0.0);
            },
            itemCount: followers.length),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {});
        });
  }
}
