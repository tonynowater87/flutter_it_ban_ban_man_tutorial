import 'dart:convert';

import 'package:flutter_it_banbanman_app/model/models/project.dart';
import 'package:http/http.dart' as http;

import 'developer.dart';

class GitHubTrendingApiError extends Error {
  String message;

  GitHubTrendingApiError(this.message);

  @override
  String toString() {
    return "GitHubTrendingApiError(message:$message)";
  }
}

class GitHubTrendingApiClient {
  http.Client _client;
  String baseDomain = "github-trending-api.now.sh";

  GitHubTrendingApiClient({client}) {
    this._client = client ?? http.Client();
  }

  Uri get baseUrl => Uri.https(baseDomain, "");

  Future<List<Project>> listProjects({String language, String since}) async {
    final reqUrl = Uri.https(baseDomain, "/repositories", {
      if (language != null) "language": language,
      if (since != null) "since": since,
    });

    final response = await _client.get(reqUrl);

    if (response.statusCode != 200) {
      throw GitHubTrendingApiError(response.body);
    }

    return jsonDecode(response.body)
        .map<Project>((project) => Project.fromJson(project))
        .toList();
  }

  Future<List<Developer>> listDeveloper({String language, String since}) async {
    final reqUrl = Uri.https(baseDomain, "/developers", {
      if (language != null) "language": language,
      if (since != null) "since": since,
    });

    final response = await _client.get(reqUrl);

    if (response.statusCode != 200) {
      throw GitHubTrendingApiError(response.body);
    }

    return jsonDecode(response.body)
        .map<Developer>((developer) => Developer.fromJson(developer))
        .toList();
  }
}
