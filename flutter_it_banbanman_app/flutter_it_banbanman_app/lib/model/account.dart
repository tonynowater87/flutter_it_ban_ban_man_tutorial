import 'package:flutter/cupertino.dart';
import 'package:github/server.dart';

import 'api/github_api.dart';

class AccountModel extends ChangeNotifier {
  CurrentUser _user;
  List<Repository> _repos;
  List<Issue> _issues;
  List<User> _followers;
  List<User> _followings;

  CurrentUser get user => _user;

  List<Repository> get repos => _repos;

  List<Issue> get issues => _issues;

  List<User> get followers => _followers;

  List<User> get followings => _followings;

  fetchFollowings() async {
    await _ensureUser();
    final List followingResult =
        await gitHubClient.getJSON("/users/${_user.login}/following");
    List<User> followingUsers = followingResult.map((user) {
      return User.fromJson(user);
    }).toList();
    _followings = followingUsers;
    notifyListeners();
  }

  fetchFollowers() async {
    await _ensureUser();
    _followers =
        await gitHubClient.users.listUserFollowers(_user.login).toList();
    notifyListeners();
  }

  fetchRepos() async {
    await _ensureUser();
    _repos = await gitHubClient.repositories
        .listUserRepositories(_user.login)
        .toList();
    notifyListeners();
  }

  fetchIssues() async {
    _issues = await gitHubClient.issues.listAll().toList();
    notifyListeners();
  }

  refreshFollowings() async {
    _followings = null;
    notifyListeners();
    await fetchFollowings();
    notifyListeners();
  }

  refreshFollowers() async {
    _followers = null;
    notifyListeners();
    await fetchFollowers();
    notifyListeners();
  }

  refreshRepos() async {
    _repos = null;
    notifyListeners();
    await fetchRepos();
    notifyListeners();
  }

  refreshIssues() async {
    _issues = null;
    notifyListeners();
    await fetchIssues();
    notifyListeners();
  }

  updateUser(CurrentUser user) {
    _user = user;
    notifyListeners();
  }

  _ensureUser() async {
    if (_user == null) {
      _user = await gitHubClient.users.getCurrentUser();
    }
  }
}
