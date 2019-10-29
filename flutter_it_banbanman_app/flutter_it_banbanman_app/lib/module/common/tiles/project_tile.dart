import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/service/models/project.dart';

class ProjectTile extends StatelessWidget {
  final Project project;

  const ProjectTile({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(project.fullName),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            project.language ?? "", /*style: TextStyle(color: Color.),*/
          )
        ],
      ),
      subtitle: Wrap(
        direction: Axis.horizontal,
        children: <Widget>[
          Text(project.description ?? ""),
          Row(
            children: <Widget>[
              Text("★ ${project.stars}"),
              SizedBox(width: 8,),
              // ignore: sdk_version_ui_as_code
              ...buildList(project.builtBy)
            ],
          )
        ],
      ),
      onTap: () {},
    );
  }

  List<Padding> buildList(List<BuiltBy> buildByList) {
    List circleAvatars = buildByList.map((buildBy) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 12.0,
          backgroundImage: NetworkImage(buildBy.avatar),
        ),
      );
    }).toList(growable: false);

    if (circleAvatars.length > 5) {
      return circleAvatars.sublist(0, 5);
    } else {
      return circleAvatars;
    }
  }
}
