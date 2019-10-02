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
import 'colors.dart';
import 'supplemental/cut_corners_border.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/diamond.png',
                  color: kShrineBrown900,
                ),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            AccentColorOverride(
                color: kShrineAltYellow,
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                      hintText: "input name",
                      /*suffixIcon: Image.asset('assets/diamond.png'),
                      prefixIcon: Image.asset('assets/diamond.png'),*/
                      labelText: "Username"),
                )),
            SizedBox(height: 20.0),
            AccentColorOverride(
              color: kShrineAltYellow,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
            ),
            ButtonBar(
              children: <Widget>[
                /*IconButton(
                  icon: Image.asset('assets/diamond.png'),
                  onPressed: () {},
                ),
                FloatingActionButton(
                  elevation: 8,
                  child: Text("FAB"),
                  onPressed: () {},
                ),*/
                FlatButton(
                  child: Text('CLEAR'),
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  onPressed: () {
                    userNameController.clear();
                    passwordController.clear();
                  },
                ),
                RaisedButton(
                  elevation: 8,
                  textColor: kShrineAltDarkGrey,
                  /*shape: CutCornersBorder(),*/
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: Text('NEXT'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// TODO: Add AccentColorOverride (103)
class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
