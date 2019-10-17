import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Language { System, Chinese, English }

class SettingLanguagePage extends StatefulWidget {
  @override
  _SettingLanguagePageState createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  Language _language = Language.English;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Language")),
      body: ListView(
        children: <Widget>[
          RadioListTile(
            title: Text("跟隨系統"),
            value: Language.System,
            groupValue: _language,
            onChanged: (language) {
              setState(() {
                _language = Language.System;
              });
            },
          ),
          RadioListTile(
              title: Text("中文"),
              value: Language.Chinese,
              groupValue: _language,
              onChanged: (language) {
                setState(() {
                  _language = Language.Chinese;
                });
              }),
          RadioListTile(
              title: Text("English"),
              value: Language.English,
              groupValue: _language,
              onChanged: (language) {
                setState(() {
                  _language = Language.English;
                });
              }),
        ],
      ),
    );
  }
}
