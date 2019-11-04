import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/common/themes.dart';
import 'package:flutter_it_banbanman_app/module/setting/setting_language.dart';

class SettingModel extends ChangeNotifier {

  ThemeData _themeData = BlueGreyTheme;
  ThemeData get themeData => _themeData;

  Language _language = Language.System;
  Language get language => _language;

  Locale _locale;
  Locale get locale => _locale;

  changeTheme(themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  changeLanguage(language) {
    _language = language;
    notifyListeners();
  }

  changeLocale(locale) {
    _locale = locale;
    notifyListeners();
  }
}