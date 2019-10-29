import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/service/models/developer.dart';
import 'package:flutter_it_banbanman_app/module/service/models/github_rending_api.dart';

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
