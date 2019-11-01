import 'package:flutter/cupertino.dart';
import 'package:github/server.dart';

import 'api/github_api.dart';

class AccountModel extends ChangeNotifier {

  CurrentUser _user;
  List<Repository> _repos;
  List<Issue> _issues;

  List<Repository> get repos => _repos;
  List<Issue> get issues => _issues;

  updateUser(CurrentUser user) {
    _user = user;
    notifyListeners();
  }

  fetchRepos() async {
    await _ensureUser();
    _repos = await gitHubClient.repositories.listUserRepositories(_user.login).toList();
    notifyListeners();
  }

  fetchIssues() async {
    _issues = await gitHubClient.issues.listAll().toList();
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

  _ensureUser() async {
    if (_user == null) {
      _user = await gitHubClient.users.getCurrentUser();
    }
  }
}
