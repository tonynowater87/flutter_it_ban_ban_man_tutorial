import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/repo_tile.dart';
import 'package:flutter_it_banbanman_app/module/common/utils.dart';
import 'package:github/server.dart';
import 'package:provider/provider.dart';

class RepoPage extends StatefulWidget {
  @override
  _RepoPageState createState() => _RepoPageState();
}

class _RepoPageState extends State<RepoPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (BuildContext context, AccountModel account, Widget child) {
        if (account.repos == null) {
          account.fetchRepos();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await account.refreshRepos();
              showToast("Refresh Repo done");
            },
            child: _buildRepoListView(account.repos),
          );
        }
      },
    );
  }

  _buildRepoListView(List<Repository> repos) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return RepoTile(
            title: repos[index].fullName,
            subTitle: repos[index].description,
            stars: repos[index].stargazersCount,
            language: repos[index].language,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: repos.length);
  }
}
