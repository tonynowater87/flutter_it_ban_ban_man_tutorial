import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
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
          fetchRepos();
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
                    itemBuilder: (BuildContext context, int index) {
                      final data = snapshot.data[index];
                      final description = data.description ?? "No description provided.";
                      return ListTile(
                        contentPadding: EdgeInsets.all(8),
                        title: Text(data.fullName),
                        trailing: Text(data.language),
                        subtitle:
                            Text("$description\n★ ${data.stargazersCount}"),
                      );
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
    CurrentUser user = await gitHub.users.getCurrentUser();
    print('[Tony] user:$user');
    return gitHub.repositories.listUserRepositories(user.login).toList();
  }
}
