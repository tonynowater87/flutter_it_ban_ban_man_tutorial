
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/module/setting/setting_language.dart';
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

String getLanguageName(BuildContext context, Language language) {
  switch(language) {
    case Language.System:
      return S.of(context).language_system;
    case Language.Chinese:
      return S.of(context).language_chinese;
    case Language.English:
      return S.of(context).language_english;
    default:
      return "";
      break;
  }
}