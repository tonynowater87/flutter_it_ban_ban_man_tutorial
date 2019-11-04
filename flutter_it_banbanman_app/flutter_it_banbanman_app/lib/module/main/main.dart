import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/module/common/preference_repository.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/main/home.dart';
import 'package:flutter_it_banbanman_app/module/main/issue.dart';
import 'package:flutter_it_banbanman_app/module/main/repo.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';

// 主頁面
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountModel>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            labelPadding: EdgeInsets.all(0),
            tabs: <Widget>[
              Tab(text: S.of(context).home),
              Tab(text: S.of(context).repo),
              Tab(text: S.of(context).activity),
              Tab(text: S.of(context).issues),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(account.user.name ?? ""),
                accountEmail: Text(account.user.htmlUrl ?? ""),
                currentAccountPicture: IconButton(
                  icon: CircleAvatar(
                    backgroundImage: NetworkImage(account.user.avatarUrl ?? ""),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesTable.profile);
                  },
                ),
                otherAccountsPictures: <Widget>[
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                ],
              ),
              DrawerTitle(
                iconData: Icons.trending_up,
                text: S.of(context).trending,
                onPressed: () {
                  Navigator.pushNamed(context, RoutesTable.trending);
                },
              ),
              DrawerTitle(
                iconData: Icons.settings,
                text: S.of(context).setting,
                onPressed: () {
                  Navigator.pushNamed(context, RoutesTable.setting);
                },
              ),
              DrawerTitle(
                iconData: Icons.info,
                text: S.of(context).about,
                onPressed: () {
                  Navigator.pushNamed(context, RoutesTable.about);
                },
              ),
              DrawerTitle(
                iconData: Icons.power_settings_new,
                text: S.of(context).signOut,
                onPressed: () async {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                            content: Text(S.of(context).dialog_logout_title),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(S.of(context).dialog_cancel),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text(S.of(context).dialog_confirm),
                                onPressed: () {
                                  PreferencesRepository _sp = PreferencesRepository();
                                  _sp.setUserName("");
                                  _sp.setUserPwd("");
                                  _sp.setAutoLogin(false);
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RoutesTable.login,
                                      ModalRoute.withName(RoutesTable.login));
                                }
                              )
                            ],
                          ));
                },
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomePage(),
            RepoPage(),
            Text("Activity"),
            IssuePage(),
          ],
        ),
      ),
    );
  }
}

class DrawerTitle extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Function onPressed;

  const DrawerTitle({Key key, this.iconData, this.text = "", this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[Icon(iconData), SizedBox(width: 24.0), Text(text)],
      ),
      onTap: onPressed ??
          () {
            print('[Tony] "not set onPressed"');
          },
    );
  }
}
