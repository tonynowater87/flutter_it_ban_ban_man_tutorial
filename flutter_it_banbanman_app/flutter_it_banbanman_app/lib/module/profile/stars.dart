import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/repo_tile.dart';
import 'package:github/server.dart';

class StartsPage extends StatefulWidget {
  @override
  _StartsPageState createState() => _StartsPageState();
}

class _StartsPageState extends State<StartsPage> {
  Future<List<Repository>> starRepos;

  @override
  void initState() {
    super.initState();
    this.starRepos = fetchStarRepos();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: FutureBuilder(
        future: starRepos,
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<List<Repository>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("has error"),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: Text("has data"),
                );
              }
              return ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  itemBuilder: (BuildContext context, int index) {
                    final data = snapshot.data[index];
                    return RepoTile(
                      title: data.fullName,
                      subTitle: data.description,
                      stars: data.stargazersCount,
                      language: data.language,
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
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {
            this.starRepos = fetchStarRepos();
          });
        });
      },
    );
  }

  Future<List<Repository>> fetchStarRepos() async {
    final currentUser = await gitHubClient.users.getCurrentUser();
    List stars = await gitHubClient
        .getJSON("/users/${currentUser.login}/starred", params: {"pages": "1"});
    List<Repository> starRepos = stars.map((star) {
      return Repository.fromJSON(star);
    }).toList();
    return starRepos;
  }
}
