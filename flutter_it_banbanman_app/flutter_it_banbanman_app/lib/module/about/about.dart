import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("About"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage("assets/images/logo.png")),
              SizedBox(
                height: 20,
              ),
              Text("跟著IT邦邦忙一起做"),
              SizedBox(
                height: 4,
              ),
              Text("0.0.1"),
            ],
          ),
          Column(children: <Widget>[
            Text("Made by Tonynowater"),
            Text("License MIT"),
            SizedBox(
              height: 20,
            )
          ])
        ],
      ),
    );
  }
}
