import 'package:flutter/services.dart';
import 'package:flutter_it_banbanman_app/module/common/constant.dart';
import 'package:flutter_it_banbanman_app/module/common/preferenceRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    print('[Tony] setUpAll');
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{
          // set initial values here if desired
        };
      }
      return null;
    });
  });

  group("Test SP", () {
    test("check SP_AUTO_LOGIN", () async {
      var sp = PreferencesRepository();
      await sp.setAutoLogin(true);
      var autoLogin = await sp.getAutoLogin();
      expect(autoLogin, true);
    });

    test("check SP_AUTO_LOGIN", () async {
      var sp = PreferencesRepository();
      await sp.setUserName("abc");
      var userName = await sp.getUserName();
      expect(userName, "abc");
    });

    test("check SP_USER_PWD", () async {
      var sp = PreferencesRepository();
      await sp.setUserPwd("123");
      var userPwd = await sp.getUserPwd();
      expect(userPwd, "123");
    });
  });

  /*testWidgets("click auto login checkbox", (WidgetTester tester) async {
    await tester.pumpWidget(GitmeRebornApp());
  });*/
}
