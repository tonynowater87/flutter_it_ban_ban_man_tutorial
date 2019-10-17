import 'package:flutter/material.dart';

enum SearchTypes { repos, users }

class MySearchDelegate extends SearchDelegate {
  SearchTypes _searchTypes = SearchTypes.repos;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super.appBarTheme(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {  // 搜尋頁面右邊功能按鈕區
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
          return [
            CheckedPopupMenuItem(
                value: SearchTypes.repos,
                checked: _searchTypes == SearchTypes.repos,
                child: Text("Search Repos")),
            CheckedPopupMenuItem(
                value: SearchTypes.users,
                checked: _searchTypes == SearchTypes.users,
                child: Text("Search Users"))
          ];
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) { // 搜尋頁面返回鍵
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) { // 搜尋結果頁面
    return Text("buildResults:($query, $_searchTypes)");
  }

  @override
  Widget buildSuggestions(BuildContext context) { // 搜尋建議頁面
    var searchPrefix;
    switch (_searchTypes) {
      case SearchTypes.repos:
        searchPrefix = "Search Repo:";
        break;
      case SearchTypes.users:
        searchPrefix = "Search User:";
        break;
    }

    return Container(
      alignment: Alignment.center,
      child: Text(searchPrefix + " " + query),
    );
  }
}
