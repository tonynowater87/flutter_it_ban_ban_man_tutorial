import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
class S implements WidgetsLocalizations {
  const S();

  static S current;

  static const GeneratedLocalizationsDelegate delegate =
    GeneratedLocalizationsDelegate();

  static S of(BuildContext context) => Localizations.of<S>(context, S);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get about => "About";
  String get activity => "Activity";
  String get app_name => "Gitmme Reborn";
  String get dialog_cancel => "No";
  String get dialog_confirm => "Yes";
  String get dialog_logout_title => "Are you sure to logout?";
  String get home => "Home";
  String get issues => "Issues";
  String get language => "Language";
  String get language_chinese => "Chinese";
  String get language_english => "English";
  String get language_system => "Follow System";
  String get login => "Login";
  String get login_auto_login => "Auto Login";
  String get login_loading => "Login...";
  String get login_password => "password";
  String get login_password_error_msg => "Not correct Password format";
  String get login_password_hint => "Your Github account password.";
  String get login_success => "Login Success";
  String get login_username => "Username";
  String get login_username_error_msg => "Not correct Username format";
  String get login_username_hint => "Your Github account user name.";
  String get main_hot_news => "Hot Hacker News";
  String get main_latest_news => "Latest Hacker News";
  String get main_trending => "Github Trending...";
  String get profile_follower => "Followers";
  String get profile_following => "Followings";
  String get profile_no_bio => "No bio yet";
  String get profile_no_location => "No location yet";
  String get profile_repo => "Repo";
  String get profile_star => "Stars";
  String get repo => "Repo";
  String get search => "Search";
  String get search_repos => "Search Repos";
  String get search_users => "Search Users";
  String get setting => "Setting";
  String get signOut => "Sign out";
  String get theme => "Theme";
  String get trending => "Trending";
  String get trending_date => "Date range";
  String get trending_date_daily => "Daily";
  String get trending_date_monthly => "Monthly";
  String get trending_date_weekly => "Weekly";
  String get trending_developer => "Developer";
  String get trending_project => "Project";
  String login_fail(String e) => "Login Fail{$e}";
  String main_comments(String user, String comments) => "by $user | $comments comments";
  String search_suggestion_repo(String query) => "Search repos that contain $query ...";
  String search_suggestion_user(String query) => "Search users that contain $query ...";
}

class $zh_TW extends S {
  const $zh_TW();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  @override
  String get trending => "趨勢";
  @override
  String get language_english => "英文";
  @override
  String get search_users => "搜尋使用者";
  @override
  String get dialog_confirm => "確定";
  @override
  String get about => "關於";
  @override
  String get language => "語言";
  @override
  String get issues => "議題";
  @override
  String get trending_developer => "開發者";
  @override
  String get setting => "設定";
  @override
  String get dialog_cancel => "取消";
  @override
  String get login_password => "密碼";
  @override
  String get main_trending => "Github 趨勢...";
  @override
  String get profile_no_location => "尚無地區";
  @override
  String get login_password_hint => "你的Github密碼";
  @override
  String get login_loading => "登入中...";
  @override
  String get language_chinese => "中文";
  @override
  String get signOut => "登出";
  @override
  String get login_username => "使用者名稱/帳號";
  @override
  String get profile_no_bio => "尚無介紹";
  @override
  String get login_success => "登入成功";
  @override
  String get login_password_error_msg => "密碼格式不正確";
  @override
  String get profile_repo => "倉庫";
  @override
  String get main_hot_news => "熱門新聞";
  @override
  String get activity => "活動";
  @override
  String get repo => "倉庫";
  @override
  String get login_username_error_msg => "使用者名稱/帳號格式不正確";
  @override
  String get login => "登入";
  @override
  String get search => "搜尋";
  @override
  String get language_system => "跟隨系統";
  @override
  String get trending_date_daily => "天";
  @override
  String get theme => "主題";
  @override
  String get profile_star => "星星";
  @override
  String get main_latest_news => "最近新聞";
  @override
  String get profile_following => "追隨中";
  @override
  String get trending_date_monthly => "月";
  @override
  String get search_repos => "搜尋倉庫";
  @override
  String get profile_follower => "追隨者";
  @override
  String get home => "首頁";
  @override
  String get dialog_logout_title => "確定登出？";
  @override
  String get app_name => "Gitmme 重生";
  @override
  String get login_username_hint => "你的Github使用者名稱/帳號";
  @override
  String get trending_date_weekly => "週";
  @override
  String get trending_project => "倉庫";
  @override
  String get trending_date => "時間區間";
  @override
  String get login_auto_login => "自動登入";
  @override
  String main_comments(String user, String comments) => "自 $user | $comments 評論";
  @override
  String search_suggestion_user(String query) => "搜尋使用者 $query ...";
  @override
  String search_suggestion_repo(String query) => "搜尋倉庫 $query ...";
  @override
  String login_fail(String e) => "登入失敗{$e}";
}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("zh", "TW"),
      Locale("en", ""),
    ];
  }

  LocaleListResolutionCallback listResolution({Locale fallback, bool withCountry = true}) {
    return (List<Locale> locales, Iterable<Locale> supported) {
      if (locales == null || locales.isEmpty) {
        return fallback ?? supported.first;
      } else {
        return _resolve(locales.first, fallback, supported, withCountry);
      }
    };
  }

  LocaleResolutionCallback resolution({Locale fallback, bool withCountry = true}) {
    return (Locale locale, Iterable<Locale> supported) {
      return _resolve(locale, fallback, supported, withCountry);
    };
  }

  @override
  Future<S> load(Locale locale) {
    final String lang = getLang(locale);
    if (lang != null) {
      switch (lang) {
        case "zh_TW":
          S.current = const $zh_TW();
          return SynchronousFuture<S>(S.current);
        case "en":
          S.current = const $en();
          return SynchronousFuture<S>(S.current);
        default:
          // NO-OP.
      }
    }
    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale, true);

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;

  ///
  /// Internal method to resolve a locale from a list of locales.
  ///
  Locale _resolve(Locale locale, Locale fallback, Iterable<Locale> supported, bool withCountry) {
    if (locale == null || !_isSupported(locale, withCountry)) {
      return fallback ?? supported.first;
    }

    final Locale languageLocale = Locale(locale.languageCode, "");
    if (supported.contains(locale)) {
      return locale;
    } else if (supported.contains(languageLocale)) {
      return languageLocale;
    } else {
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    }
  }

  ///
  /// Returns true if the specified locale is supported, false otherwise.
  ///
  bool _isSupported(Locale locale, bool withCountry) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        // Language must always match both locales.
        if (supportedLocale.languageCode != locale.languageCode) {
          continue;
        }

        // If country code matches, return this locale.
        if (supportedLocale.countryCode == locale.countryCode) {
          return true;
        }

        // If no country requirement is requested, check if this locale has no country.
        if (true != withCountry && (supportedLocale.countryCode == null || supportedLocale.countryCode.isEmpty)) {
          return true;
        }
      }
    }
    return false;
  }
}

String getLang(Locale l) => l == null
  ? null
  : l.countryCode != null && l.countryCode.isEmpty
    ? l.languageCode
    : l.toString();
