import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  static SharedPreferences _sharedPreferences;

  static const SP_AUTO_LOGIN = "SP_AUTO_LOGIN";
  static const SP_USER_NAME = "SP_USER_NAME";
  static const SP_USER_PWD = "SP_USER_PWD";
  static const SP_LOCALE = "SP_LOCALE";

  Future<SharedPreferences> get sharedPreferences async {
    if (_sharedPreferences != null) return _sharedPreferences;

    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences;
  }

  Future<bool> getAutoLogin() async {
    final sp = await sharedPreferences;
    return sp.getBool(SP_AUTO_LOGIN) ?? false;
  }

  Future<bool> setAutoLogin(bool autoLogin) async {
    final sp = await sharedPreferences;
    return sp.setBool(SP_AUTO_LOGIN, autoLogin);
  }

  Future<String> getUserName() async {
    final sp = await sharedPreferences;
    return sp.getString(SP_USER_NAME) ?? "";
  }

  Future<bool> setUserName(String userName) async {
    final sp = await sharedPreferences;
    return sp.setString(SP_USER_NAME, userName);
  }

  Future<String> getUserPwd() async {
    final sp = await sharedPreferences;
    return sp.getString(SP_USER_PWD) ?? "";
  }

  Future<bool> setUserPwd(String userPwd) async {
    final sp = await sharedPreferences;
    return sp.setString(SP_USER_PWD, userPwd);
  }

  Future<String> getLocale() async {
    final sp = await sharedPreferences;
    return sp.getString(SP_LOCALE);
  }

  Future<bool> setLocale(String locale) async {
    final sp = await sharedPreferences;
    return sp.setString(SP_LOCALE, locale);
  }

  Future<bool> clear() async {
    final sp = await sharedPreferences;
    return sp.clear();
  }
}
