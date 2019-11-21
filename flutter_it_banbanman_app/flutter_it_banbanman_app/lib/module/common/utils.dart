import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/module/common/const.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> searchLanguageColorHexString(String language) async {
  if (language == null) {
    return null;
  } else {
    String colors =
        await rootBundle.loadString("assets/data/github_colors.json");
    var githubColorsMap = jsonDecode(colors);
    return githubColorsMap[language]["color"];
  }
}

showToast(String msg) {
  Fluttertoast.showToast(msg: msg);
}

String getLanguageName(BuildContext context, Locale locale) {
  if (locale == null) {
    return S.of(context).language_system;
  }

  if (locale == Locale_ZH) {
    return S.of(context).language_chinese;
  }

  if (locale == Locale_EN) {
    return S.of(context).language_english;
  }

  return "";
}
