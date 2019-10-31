
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> searchLanguageColorHexString(String language) async {
  if (language == null) {
    return null;
  } else {
    String colors = await rootBundle.loadString("assets/data/github_colors.json");
    var githubColorsMap = jsonDecode(colors);
    return githubColorsMap[language]["color"];
  }
}

showToast(String msg) {
  Fluttertoast.showToast(msg: msg);
}