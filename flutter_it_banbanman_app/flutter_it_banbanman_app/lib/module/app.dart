import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:flutter_it_banbanman_app/model/account.dart';
import 'package:flutter_it_banbanman_app/model/setting.dart';
import 'package:flutter_it_banbanman_app/module/bloc_supervisor_delegate.dart';
import 'package:flutter_it_banbanman_app/module/login/bloc/bloc.dart';
import 'package:flutter_it_banbanman_app/module/profile/profile.dart';
import 'package:flutter_it_banbanman_app/module/setting/setting_language.dart';
import 'package:flutter_it_banbanman_app/module/setting/setting_page.dart';
import 'package:flutter_it_banbanman_app/module/splash/splash_page.dart';
import 'package:flutter_it_banbanman_app/module/trending/trending.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'about/about.dart';
import 'common/locale/locale_handler.dart';
import 'common/locale/overriden_localization_delegate.dart';
import 'common/routes.dart';
import 'login/login_page.dart';
import 'main/main.dart';
import 'package:bloc/bloc.dart';

Future main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
        RoutesTable.splash: (context) => _appendLoginBloc(SplashPage()),
        RoutesTable.login: (context) => _appendLoginBloc(LoginPage()),
        RoutesTable.main: (context) => MainPage(),
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
            return MaterialPageRoute(builder: (context) => _appendLoginBloc(SplashPage()));
          default:
            return MaterialPageRoute(builder: (context) => _appendLoginBloc(SplashPage()));
        }
      },
    );
  }
  Widget _appendLoginBloc(Widget widget) {
    return BlocProvider(
        builder: (context) => LoginBloc(), child: widget);
  }
}