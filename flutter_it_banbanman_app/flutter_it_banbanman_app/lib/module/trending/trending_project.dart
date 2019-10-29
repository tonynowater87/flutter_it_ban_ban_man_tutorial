import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/project_tile.dart';
import 'package:flutter_it_banbanman_app/module/service/models/github_rending_api.dart';
import 'package:flutter_it_banbanman_app/module/service/models/project.dart';
import 'package:flutter_it_banbanman_app/module/trending/trending.dart';

class TrendingProjectPage extends StatefulWidget {

  final TrendingDateRange dateRange;

  const TrendingProjectPage({Key key, @required this.dateRange}) : super(key: key);

  @override
  _TrendingProjectPageState createState() => _TrendingProjectPageState();
}

class _TrendingProjectPageState extends State<TrendingProjectPage> {
  Future<List<Project>> projects;

  @override
  Widget build(BuildContext context) {
    print('[Tony] build TrendingProjectPage');
    projects = fetchProjects();
    return RefreshIndicator(
        onRefresh: () async {
          setState(() {
            projects = fetchProjects();
          });
        },
        child: FutureBuilder(
            future: projects,
            builder:
                (BuildContext context, AsyncSnapshot<List<Project>> snapshot) {
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
                      itemBuilder: (context, index) {
                        final trendingProject = snapshot.data;
                        return ProjectTile(project: trendingProject[index],);
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 0);
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

              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }

  Future<List<Project>> fetchProjects() async {
    var since = widget.dateRange.toString().split('.')[1];
    print('[Tony] fetchProjects:$since');
    return GitHubTrendingApiClient().listProjects(since: since);
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

    if (circleAvatars.length > 3) {
      return circleAvatars.sublist(0, 3);
    } else {
      return circleAvatars;
    }
  }
}