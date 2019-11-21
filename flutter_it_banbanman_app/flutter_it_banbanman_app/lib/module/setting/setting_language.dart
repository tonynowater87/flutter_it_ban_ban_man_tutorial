import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/setting.dart';
import 'package:flutter_it_banbanman_app/module/common/const.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';
import 'package:provider/provider.dart';

class SettingLanguagePage extends StatefulWidget {
  @override
  _SettingLanguagePageState createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  SettingModel _setting;

  @override
  Widget build(BuildContext context) {
    _setting = Provider.of<SettingModel>(context);

    return Scaffold(
      appBar:
          AppBar(leading: BackButton(), title: Text(S.of(context).language)),
      body: ListView(
        children: <Widget>[
          RadioListTile(
            title: Text(S.of(context).language_system),
            value: null,
            groupValue: _setting.locale,
            onChanged: _changeLocale,
          ),
          RadioListTile(
              title: Text(S.of(context).language_chinese),
              value: Locale_ZH,
              groupValue: _setting.locale,
              onChanged: _changeLocale),
          RadioListTile(
              title: Text(S.of(context).language_english),
              value: Locale_EN,
              groupValue: _setting.locale,
              onChanged: _changeLocale),
        ],
      ),
    );
  }

  void _changeLocale(Locale locale) {
    PreferencesRepository().setLocale(locale == null ? "" : locale.toString());
    _setting.changeLocale(locale);
    print('[Tony] change $locale');
  }
}
