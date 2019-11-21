import 'dart:ui';

import 'package:flutter_it_banbanman_app/module/common/const.dart';

abstract class LocaleHandler {

  bool isTC(Locale locale) =>
      (locale.languageCode == "zh" &&
          (locale.countryCode == "HK" || locale.countryCode == "TW")) ||
          (locale.languageCode == "zh" && locale.scriptCode == "Hant");

  bool isSC(Locale locale) =>
      (locale.languageCode == "zh" && locale.countryCode == "CN") ||
          (locale.languageCode == "zh" && locale.scriptCode == "Hans");

  resolveLocale(Locale locale, Iterable<Locale> supported) {

    if (locale == null) {
      return Locale_EN;
    } else if (isTC(locale)) {
      return Locale_ZH;
    } else {
      return Locale_EN;
    }
  }
}