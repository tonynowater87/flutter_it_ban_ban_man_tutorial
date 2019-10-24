import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/api/github_api.dart';
import 'package:github/server.dart';

class IssuePage extends StatefulWidget {
  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  Future<List<Issue>> issueList;

  @override
  void initState() {
    super.initState();
    this.issueList = fetchIssues();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {
            issueList = fetchIssues();
          });
        });
      },
      child: FutureBuilder(
        future: issueList,
        builder: (BuildContext context, AsyncSnapshot<List<Issue>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text("has error"),
                );
              }
              if (!snapshot.hasData || snapshot.data.isEmpty) {
                return Center(
                  child: Text("no data"),
                );
              }
              return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data[index];
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
                  itemCount: snapshot.data.length);
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<Issue>> fetchIssues() async {
    print('[Tony] fetchIssues');
    return gitHubClient.issues.listAll(state: "all").toList();
  }
}
