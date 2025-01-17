// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'backdrop.dart';
import 'model/product.dart';
import 'home.dart';
import 'login.dart';
import 'colors.dart';
import 'supplemental/cut_corners_border.dart';
import 'category_menu_page.dart';

class ShrineApp extends StatefulWidget {
  @override
  _ShrineAppState createState() {
    return new _ShrineAppState();
  }
}

class _ShrineAppState extends State<ShrineApp> {
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      home: Backdrop(
          currentCategory: Category.all,
          frontLayer: HomePage(category: _currentCategory,),
          backLayer: CategoryMenuPage(
              currentCategory: _currentCategory, onCategoryTap: _onCategoryTap),
          frontTitle: Text("SHRINE"),
          backTitle: Text("MENU")),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      theme: _kShrineTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}

// TODO: Build a Shrine Theme (103)
final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kShrineBrown900,
    primaryColor: kShrinePink100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kShrinePink100,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: kShrineBackgroundWhite,
    cardColor: kShrineBackgroundWhite,
    textSelectionColor: kShrinePink100,
    errorColor: kShrineErrorRed,
    textTheme: _buildShrineTextTheme(base.textTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    primaryIconTheme: base.primaryIconTheme.copyWith(color: kShrineBrown900),
    /*inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),*/
    // TODO: Decorate the inputs (103)
    inputDecorationTheme: InputDecorationTheme(
      border: CutCornersBorder(), // Replace code
    ),
  );
}

// TODO: Build a Shrine Text Theme (103);
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(fontWeight: FontWeight.w500),
        title: base.title.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}
