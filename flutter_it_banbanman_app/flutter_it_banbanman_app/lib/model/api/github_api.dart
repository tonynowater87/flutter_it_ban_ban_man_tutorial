import 'package:github/server.dart';

GitHub gitHubClient;

GitHub getGithubClient({String useName = "", String password = "", String token}) {
    if (useName.isNotEmpty && password.isNotEmpty) {
        return GitHub(auth: Authentication.basic(useName, password));
    } else if (token != null) {
        return GitHub(auth: Authentication.withToken(token));
    } else {
        throw Exception("not providing params userName, password, token");
    }
}
