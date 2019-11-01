import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeTab extends StatelessWidget {

  final String labelText;
  final String badgeText;

  BadgeTab({Key key, @required this.labelText, this.badgeText = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(labelText),
          // ignore: sdk_version_ui_as_code
          if (badgeText.isNotEmpty) SizedBox(width: 5,),
          if (badgeText.isNotEmpty)
            Badge(
              badgeColor: Colors.white,
              shape: BadgeShape.circle,
              padding: EdgeInsets.symmetric(horizontal: 5),
              badgeContent: Text(badgeText, style: Theme.of(context).textTheme.caption,),
            )
        ],
      ),
    );
  }
}
