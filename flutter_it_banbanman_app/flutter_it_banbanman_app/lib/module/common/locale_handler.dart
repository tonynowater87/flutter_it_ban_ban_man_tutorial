import 'dart:ui';

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
      return Locale("en", "");
    } else if (isTC(locale)) {
      return Locale("zh", "TW");
    } else if (locale.languageCode == "zh") {
      return Locale("zh", "TW");
    } else {
      return Locale("en", "");
    }
  }
}