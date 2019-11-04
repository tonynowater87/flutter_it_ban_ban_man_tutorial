import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_it_banbanman_app/generated/i18n.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  String appVersion;

  @override
  void initState() {
    super.initState();
    fetchAppVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(S.of(context).about),
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
              Text(appVersion ?? ""),
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

  void fetchAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
      print('[Tony] appVersion:$appVersion');
    });
  }
}
