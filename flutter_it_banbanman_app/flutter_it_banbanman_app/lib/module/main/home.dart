import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {},
      child: Container(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                "最新",
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0,
              color: Colors.blueGrey,
            ),
            ListTile(
              title: Text(
                "歡迎使用Gitme v1.1.1",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text("每一位用戶都是gitme的主人!"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {},
            ),
            Divider(
              height: 0,
              thickness: 10,
              color: Colors.grey,
            ),
            ListTile(
              title: Text(
                "推薦項目",
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Divider(
              height: 0,
              thickness: 0,
              color: Colors.blueGrey,
            ),
            ListTile(
              title: Text(
                "flukit",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text("A Flutter UI Kit"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
