import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/model/models/github_trending_api.dart';
import 'package:flutter_it_banbanman_app/model/models/project.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/project_tile.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HnpwaClient hnpwaClient = HnpwaClient();

  List<FeedItem> tops;
  List<FeedItem> newsest;
  List<Project> projects;

  @override
  void initState() {
    super.initState();
    print('[Tony] initState');
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1)).then((value) {
              fetchNews();
            });
          },
          child: ListView(
            children: <Widget>[
              Divider(
                height: 0,
                thickness: 2,
              ),
              ListTile(
                title: Text("Hackernews Top"),
                dense: true,
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
              Divider(
                height: 0,
                thickness: 2,
              ),
              // ignore: sdk_version_ui_as_code
              ...buildTop(context, tops),
              Divider(
                height: 0,
                thickness: 2,
              ),
              ListTile(
                title: Text("Hackernews New"),
                dense: true,
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
              Divider(
                height: 0,
                thickness: 2,
              ),
              // ignore: sdk_version_ui_as_code
              ...buildTop(context, newsest),
              Divider(
                height: 0,
                thickness: 2,
              ),
              ListTile(
                title: Text("Github Trendings..."),
                dense: true,
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.pushNamed(context, RoutesTable.trending);
                },
              ),
              Divider(
                height: 0,
                thickness: 2,
              ),
              // ignore: sdk_version_ui_as_code
              ...buildTrendingRepos(context)
            ],
          )),
    );
  }

  void fetchNews() async {
    Feed top = await hnpwaClient.news();
    print('[Tony] fetchNews:$top');

    Feed newsest = await hnpwaClient.newest();
    print('[Tony] fetchNewest:$newsest');

    final project = await GitHubTrendingApiClient().listProjects();

    setState(() {
      this.tops = top.items;
      this.newsest = newsest.items;
      this.projects = project;
    });
  }

  buildTop(BuildContext context, List<FeedItem> items) {
    if (items == null) {
      return [
        Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator(),),
        )
      ];
    } else {
      return ListTile.divideTiles(
              context: context,
              tiles: items.sublist(0, 4).map((item) {
                return ListTile(
                  title: Text(item.title),
                  subtitle:
                      Text("by ${item.user} | ${item.commentsCount} comments"),
                  onTap: () {
                    _launchURL(item.url);
                  },
                );
              }).toList())
          .toList();
    }
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  buildTrendingRepos(BuildContext context) {
    if (projects == null) {
      return [
        Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator(),),
        )
      ];
    } else {
      return ListTile.divideTiles(
              context: context,
              tiles: projects.sublist(0, 4).map((project) {
                return ProjectTile(project: project);
              }).toList())
          .toList();
    }
  }
}
