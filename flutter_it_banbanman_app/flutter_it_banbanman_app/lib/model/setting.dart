import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/common/themes.dart';

class SettingModel extends ChangeNotifier {
  ThemeData _themeData = BlueGreyTheme;
  ThemeData get themeData => _themeData;

  changeTheme(themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}