import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/model/setting.dart';
import 'package:flutter_it_banbanman_app/module/about/about.dart';
import 'package:flutter_it_banbanman_app/module/common/locale/overriden_localization_delegate.dart';
import 'package:flutter_it_banbanman_app/module/common/locale_handler.dart';
import 'package:flutter_it_banbanman_app/module/common/routes.dart';
import 'package:flutter_it_banbanman_app/module/main/home.dart';
import 'package:flutter_it_banbanman_app/module/main/issue.dart';
import 'package:flutter_it_banbanman_app/module/main/repo.dart';
import 'package:flutter_it_banbanman_app/module/profile/profile.dart';
import 'package:flutter_it_banbanman_app/module/setting/setting_language.dart';
import 'package:flutter_it_banbanman_app/module/setting/setting_page.dart';
import 'package:flutter_it_banbanman_app/module/trending/trending.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../login/login_page.dart';
import '../search/search_delegate.dart';

Future main() async {
  print('[Tony] app onCreate');
  await DotEnv().load('.env');
  String token = DotEnv().env["GITHUB_TOKEN"];
  print('[Tony] Token:$token');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(builder: (BuildContext context) => AccountModel()),
      ChangeNotifierProvider(builder: (BuildContext context) => SettingModel())
    ],
    child: GitmeRebornApp(),
  ));
}

class GitmeRebornApp extends StatelessWidget with LocaleHandler {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final setting = Provider.of<SettingModel>(context);

    return MaterialApp(
      title: "Gitmme Reborn",
      theme: setting.themeData,
      routes: {
        RoutesTable.login: (context) => LoginPage(),
        RoutesTable.home: (context) => MainPage(),
        RoutesTable.profile: (context) => ProfilePage(),
        RoutesTable.trending: (context) => TrendingPage(),
        RoutesTable.setting: (context) => SettingPage(),
        RoutesTable.settingLanguage: (context) => SettingLanguagePage(),
        RoutesTable.about: (context) => AboutPage(),
      },
      localizationsDelegates: [
        OverriddenLocalizationsDelegate(setting.locale),
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        var resolvedLocale = resolveLocale(locale, supportedLocales);
        print('[Tony] localeResolutionCallback:$resolvedLocale');
        return resolvedLocale;
      },
      onGenerateRoute: (settings) {
        print('[Tony] initial value is RouteSettings("/", null)');
        switch (settings.name) {
          case RoutesTable.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
    );
  }
}

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
                            content: Text("確定登出?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("取消"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              FlatButton(
                                child: Text("確定"),
                                onPressed: () =>
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesTable.login,
                                        ModalRoute.withName(RoutesTable.login)),
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
