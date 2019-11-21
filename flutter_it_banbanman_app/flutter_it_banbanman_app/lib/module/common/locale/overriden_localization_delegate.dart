import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';

class OverriddenLocalizationsDelegate extends LocalizationsDelegate<S> {

  final Locale overriddenLocale;

  const OverriddenLocalizationsDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<S> load(Locale locale) {
    print('[OverriddenLocalizationsDelegate] overriddenLocale:$locale');
    return S.delegate.load(overriddenLocale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<S> old) => true;
}