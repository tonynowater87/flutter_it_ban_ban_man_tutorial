import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/repo_tile.dart';
import 'package:github/server.dart';

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  Future<List<Repository>> remoteRepoList;

  @override
  void initState() {
    super.initState();
    remoteRepoList = fetchRepos();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {
            remoteRepoList = fetchRepos();
          });
        });
      },
      child: Container(
          child: FutureBuilder(
        future: remoteRepoList,
        builder: (BuildContext context, AsyncSnapshot<List<Repository>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (!snapshot.hasError) {
                print('[Tony] ConnectionState.done');
                return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    itemBuilder: (BuildContext context, int index) {
                      final data = snapshot.data[index];
                      return RepoTile(title: data.fullName,
                        subTitle: data.description,
                        stars: data.stargazersCount,
                        language: data.language,);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        height: 0,
                      );
                    },
                    itemCount: snapshot.data.length);
              } else {
                return Center(
                  child: Text("No Data"),
                );
              }
              break;
            case ConnectionState.none:
              print('[Tony] ConnectionState.none');
              break;
            case ConnectionState.waiting:
              print('[Tony] ConnectionState.waiting');
              break;
            case ConnectionState.active:
              print('[Tony] ConnectionState.active');
              break;
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  Future<List<Repository>> fetchRepos() async {
    CurrentUser user = await gitHubClient.users.getCurrentUser();
    print('[Tony] fetchRepos');
    return gitHubClient.repositories.listUserRepositories(user.login).toList();
  }
}
