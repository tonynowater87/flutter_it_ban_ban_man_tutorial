import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/setting.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/common/themes.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(S.of(context).setting),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            children: [
              Wrap(
                direction: Axis.horizontal,
                spacing: 8,
                children: <Widget>[
                  SquareWidget(
                    color: Colors.black,
                    clickListener: () {
                      setting.changeTheme(BlackTheme);
                    },
                  ),
                  SquareWidget(
                      color: Colors.blue,
                      clickListener: () {
                        setting.changeTheme(BlueTheme);
                      }),
                  SquareWidget(
                      color: Colors.blueGrey,
                      clickListener: () {
                        setting.changeTheme(BlueGreyTheme);
                      }),
                ],
              )
            ],
            title: Text(S.of(context).theme),
            leading: Icon(
              Icons.palette,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
            ),
            title: Text(S.of(context).language),
            trailing: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(setting.language.toString()),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutesTable.settingLanguage);
            },
          )
        ],
      ),
    );
  }
}

class ThemeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ExpansionTile(
            children: <Widget>[
              Card(color: Colors.black),
              Card(color: Colors.blue),
              Card(color: Colors.blueGrey),
            ],
            title: Row(
              children: <Widget>[
                Icon(Icons.palette),
                SizedBox(width: 16),
                Text(S.of(context).theme),
                Icon(Icons.keyboard_arrow_up)
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: 2);
  }
}

typedef void OnSquareWidgetClickListener();

class SquareWidget extends StatelessWidget {
  final Color color;
  final OnSquareWidgetClickListener clickListener;

  SquareWidget({Key key, this.color, this.clickListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
          padding: EdgeInsets.all(4.0),
          child: SizedBox(
            width: 40,
            height: 40,
            child: DecoratedBox(
              decoration: BoxDecoration(color: this.color),
            ),
          )),
      onTap: () {
        clickListener();
      },
    );
  }
}
