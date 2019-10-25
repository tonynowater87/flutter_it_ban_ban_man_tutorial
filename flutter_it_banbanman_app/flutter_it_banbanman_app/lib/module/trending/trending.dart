import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/service/models/developer.dart';
import 'package:flutter_it_banbanman_app/module/service/models/github_rending_api.dart';
import 'package:flutter_it_banbanman_app/module/service/models/project.dart';

enum TrendingDateRange { Daily, Weekly, Monthly }

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  TrendingDateRange _dateRange = TrendingDateRange.Daily;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(),
            title: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[Tab(text: "Project"), Tab(text: "Developer")],
            ),
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      child: Text("Date range"),
                    ),
                    CheckedPopupMenuItem(
                      child: Text("daily"),
                      value: TrendingDateRange.Daily,
                      checked: _dateRange == TrendingDateRange.Daily,
                    ),
                    CheckedPopupMenuItem(
                      child: Text("weekly"),
                      value: TrendingDateRange.Weekly,
                      checked: _dateRange == TrendingDateRange.Weekly,
                    ),
                    CheckedPopupMenuItem(
                      child: Text("monthly"),
                      value: TrendingDateRange.Monthly,
                      checked: _dateRange == TrendingDateRange.Monthly,
                    )
                  ];
                },
                onSelected: (value) {
                  setState(() {
                    print('[Tony] select:$value');
                    _dateRange = value;
                  });
                },
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              TrendingProjectPage(),
              TrendingDeveloperPage(),
            ],
          ),
        ));
  }
}

class TrendingProjectPage extends StatefulWidget {
  TrendingProjectPage({Key key}) : super(key: key) {}

  @override
  _TrendingProjectPageState createState() => _TrendingProjectPageState();
}

class _TrendingProjectPageState extends State<TrendingProjectPage> {
  Future<List<Project>> projects;

  @override
  void initState() {
    super.initState();
    projects = fetchProjects();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 2), () {
            setState(() {
              projects = fetchProjects();
            });
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
                        return ListTile(
                          title: Text(trendingProject[index].fullName),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 4.0),
                                Text(trendingProject[index].description),
                                SizedBox(height: 4.0),
                                Row(
                                  children: <Widget>[
                                    Text("★ ${trendingProject[index].stars}"),
                                    // ignore: sdk_version_ui_as_code
                                    ...buildList(trendingProject[index].builtBy)
                                  ],
                                )
                              ]),
                          trailing: Text(trendingProject[index].language ?? ""),
                          //todo colors
                          onTap: () {},
                        );
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
    return GitHubTrendingApiClient().listProjects();
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

class TrendingDeveloperPage extends StatefulWidget {
  TrendingDeveloperPage({Key key}) : super(key: key);

  @override
  _TrendingDeveloperPageState createState() => _TrendingDeveloperPageState();
}

class _TrendingDeveloperPageState extends State<TrendingDeveloperPage> {
  Future<List<Developer>> developers;

  @override
  void initState() {
    super.initState();
    developers = fetchDevelopers();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {
            developers = fetchDevelopers();
          });
        });
      },
      child: FutureBuilder(
        future: developers,
        builder:
            (BuildContext context, AsyncSnapshot<List<Developer>> snapshot) {
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
                    final data = snapshot.data;

                    return ListTile(
                      contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index].avatar),
                      ),
                      title: Row(children: [
                        Text(data[index].name),
                        SizedBox(width: 16),
                        Text(data[index].username)
                      ]),
                      subtitle: Text(data[index].repo.description),
                      onTap: () {},
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 0);
                  },
                  itemCount: snapshot.data.length);
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
        },
      ),
    );
  }

  Future<List<Developer>> fetchDevelopers() async {
    return await GitHubTrendingApiClient().listDeveloper();
  }
}
