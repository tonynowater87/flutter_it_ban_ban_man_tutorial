import 'package:flutter_it_banbanman_app/module/service/models/developer.dart';
import 'package:flutter_it_banbanman_app/module/service/models/github_rending_api.dart';
import 'package:flutter_it_banbanman_app/module/service/models/project.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test GitHub trending APIs", () {
    test("Test listProjects", () async {
      final api = GitHubTrendingApiClient();
      final response = await api.listProjects();
      expect(response, isInstanceOf<List<Project>>());
    });

    test("Test listDevelopers", () async {
      final api = GitHubTrendingApiClient();
      final response = await api.listDeveloper();
      expect(response, isInstanceOf<List<Developer>>());
    });
  });
}
