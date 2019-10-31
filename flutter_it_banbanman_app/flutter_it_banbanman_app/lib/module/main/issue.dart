import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:github/server.dart';
import 'package:provider/provider.dart';

class IssuePage extends StatefulWidget {
  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModel>(
      builder: (context, account, widget) {
        if (account.issues == null) {
          account.fetchIssues();
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              account.refreshIssues();
            },
            child: _buildIssueListView(account.issues),
          );
        }
      },
    );
  }

  _buildIssueListView(List<Issue> issues) {
    if (issues.isEmpty) {
      return Center(child: Text("No Issues."),);
    } else
      return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            var data = issues[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data.url),
              ),
              title: Text(data.title),
              subtitle: Text(data.createdAt.toIso8601String()),
              trailing: Icon(Icons.info),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 0,
            );
          },
          itemCount: issues.length);
  }
}
