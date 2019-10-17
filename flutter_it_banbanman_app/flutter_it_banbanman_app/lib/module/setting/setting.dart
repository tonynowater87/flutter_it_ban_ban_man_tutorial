import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Setting"),
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
                  ),
                  SquareWidget(
                    color: Colors.blue,
                  ),
                  SquareWidget(
                    color: Colors.blueGrey,
                  ),
                ],
              )
            ],
            title: Text("Theme"),
            leading: Icon(
              Icons.palette,
              color: Colors.blueGrey,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.language,
              color: Colors.blueGrey,
            ),
            title: Text("Language"),
            trailing: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text("English"),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            onTap: () {},
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
              Card(
                color: Colors.black,
              ),
              Card(color: Colors.blue),
              Card(color: Colors.blueGrey),
            ],
            title: Row(
              children: <Widget>[
                Icon(Icons.palette),
                SizedBox(width: 16),
                Text("Theme"),
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

class SquareWidget extends StatelessWidget {
  final Color color;

  SquareWidget({Key key, this.color}) : super(key: key);

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
        print('[Tony] tap $color');
      },
    );
  }
}
