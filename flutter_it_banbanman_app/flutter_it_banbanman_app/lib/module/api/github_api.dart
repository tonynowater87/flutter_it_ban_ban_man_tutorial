import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github/server.dart';

GitHub gitHub = GitHub(
  auth: Authentication.withToken(DotEnv().env['GITHUB_TOKEN'])
);