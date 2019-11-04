import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/api/github_api.dart';
import 'package:flutter_it_banbanman_app/model/setting.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/repo_tile.dart';
import 'package:flutter_it_banbanman_app/module/common/tiles/user_tile.dart';
import 'package:github/server.dart';
import 'package:provider/provider.dart';

enum SearchTypes { repos, users }

class MySearchDelegate extends SearchDelegate {
  SearchTypes _searchTypes = SearchTypes.repos;
  Future<List<User>> users;
  Future<List<Repository>> repos;

  @override
  ThemeData appBarTheme(BuildContext context) {
    var setting = Provider.of<SettingModel>(context);
    return setting.themeData;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // 搜尋頁面右邊功能按鈕區
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
      PopupMenuButton(
        onSelected: (SearchTypes type) {
          _searchTypes = type;
          showSuggestions(context); //update suggestion
        },
        itemBuilder: (BuildContext context) {
          // 預設的搜尋主頁面
          return [
            CheckedPopupMenuItem(
                value: SearchTypes.repos,
                checked: _searchTypes == SearchTypes.repos,
                child: Text(S.of(context).search_repos)),
            CheckedPopupMenuItem(
                value: SearchTypes.users,
                checked: _searchTypes == SearchTypes.users,
                child: Text(S.of(context).search_users))
          ];
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // 搜尋頁面返回鍵
    return BackButton();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // 搜尋建議頁面
    switch (_searchTypes) {
      case SearchTypes.users:
        return Center(child: Text(S.of(context).search_suggestion_user(query)));
      case SearchTypes.repos:
        return Center(child: Text(S.of(context).search_suggestion_repo(query)));
    }

    throw Exception("Illegal SearchType:$_searchTypes");
  }

  @override
  Widget buildResults(BuildContext context) {
    print('[Tony] buildResults');
    // 搜尋結果頁面
    return SearchResultPage(
      query: query,
      searchTypes: _searchTypes,
    );
  }
}

class SearchResultPage extends StatefulWidget {
  final String query;
  final SearchTypes searchTypes;

  SearchResultPage({Key key, @required this.query, @required this.searchTypes})
      : super(key: key);

  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  Future<List> searchResults;

  @override
  void initState() {
    super.initState();
    switch (widget.searchTypes) {
      case SearchTypes.users:
        searchResults = searchUsers(widget.query);
        break;
      case SearchTypes.repos:
        searchResults = searchRepos(widget.query);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchResults,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Text("No Data"),
              );
            }
            return ListView.separated(
              // ignore: missing_return
            itemBuilder: (BuildContext context, int index) {
                  switch (widget.searchTypes) {
                    case SearchTypes.repos:
                      final data = snapshot.data.cast<Repository>()[index];
                      return RepoTile(
                        title: data.fullName,
                        subTitle: data.description,
                        stars: data.stargazersCount,
                        language: data.language,
                      );
                    case SearchTypes.users:
                      final data = snapshot.data.cast<User>()[index];
                      return UserTile(
                        avatarUrl: data.avatarUrl,
                        userName: data.login,
                      );
                  }
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
            break;
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<List<User>> searchUsers(String query) async {
    return gitHubClient.search.users(query, pages: 1).toList();
  }

  Future<List<Repository>> searchRepos(String query) async {
    return gitHubClient.search.repositories(query, pages: 1).toList();
  }
}