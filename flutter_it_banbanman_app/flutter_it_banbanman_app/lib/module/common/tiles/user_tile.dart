import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String avatarUrl;
  final String userName;

  UserTile({Key key, this.avatarUrl, this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
      ),
      title: Text(userName),
      onTap: () {},
    );
  }
}
