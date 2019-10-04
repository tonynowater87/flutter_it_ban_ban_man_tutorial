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
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 150,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("SliverAppBar Test"),
            background: Image.network(
              "https://avatars3.githubusercontent.com/u/9815472?s=460&v=4",
              fit: BoxFit.cover,
            ),
          ),
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
            ))
      ]),
    );
  }
}
