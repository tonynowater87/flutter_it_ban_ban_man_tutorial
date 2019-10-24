import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepoTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String language;
  final int stars;

  RepoTile({Key key, this.title, this.subTitle, this.stars, this.language})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    final description = subTitle ?? "No description provided";

    return ListTile(
      title: Text(title),
      subtitle: Text("$description\n★ $stars"),
      trailing: Text(language ?? ""),
      onTap: () {},
    );
  }
}