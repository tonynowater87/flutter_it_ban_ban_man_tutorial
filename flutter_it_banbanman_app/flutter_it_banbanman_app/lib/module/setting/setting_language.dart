import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/setting.dart';
import 'package:provider/provider.dart';

enum Language {
  System, Chinese, English
}

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
      appBar: AppBar(
          leading: BackButton(),
          title: Text(S
              .of(context)
              .language)),
      body: ListView(
        children: <Widget>[
          RadioListTile(
            title: Text(S.of(context).language_system),
            value: Language.System,
            groupValue: _setting.language,
            onChanged: _changeLanguage,
          ),
          RadioListTile(
              title: Text(S.of(context).language_chinese),
              value: Language.Chinese,
              groupValue: _setting.language,
              onChanged: _changeLanguage),
          RadioListTile(
              title: Text(S.of(context).language_english),
              value: Language.English,
              groupValue: _setting.language,
              onChanged: _changeLanguage),
        ],
      ),
    );
  }

  void _changeLanguage(Language language) async {
    _setting.changeLanguage(language);
    switch (language) {
      case Language.System: {
        var systemLocale = Localizations.localeOf(context);
        print('[Tony] change system locale:$systemLocale');
        _setting.changeLocale(systemLocale);
        break;
      }
      case Language.Chinese:
        print('[Tony] change tw');
        _setting.changeLocale(Locale("zh", "TW"));
        break;
      case Language.English:
        print('[Tony] change us');
        _setting.changeLocale(Locale("en", "US"));
        break;
    }
  }
}
