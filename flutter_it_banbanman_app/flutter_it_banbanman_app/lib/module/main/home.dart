import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HnpwaClient hnpwaClient = HnpwaClient();

  List<FeedItem> tops;
  List<FeedItem> newsest;

  @override
  void initState() {
    super.initState();
    print('[Tony] initState');
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1)).then((value) {
            fetchNews();
          });
        },
        child: Column(
          children: <Widget>[
            Divider(
              height: 5,
              thickness: 5.0,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: buildTop(tops),
            ),
            Divider(
              height: 5,
              thickness: 5.0,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: buildTop(newsest),
            )
          ],
        ));
  }

  void fetchNews() async {
    Feed top = await hnpwaClient.news();
    Feed newsest = await hnpwaClient.newest();

    print('[Tony] fetchNews:$top');
    print('[Tony] fetchNews:$newsest');
    setState(() {
      this.tops = top.items;
      this.newsest = newsest.items;
    });
  }

  Widget buildTop(List<FeedItem> items) {
    if (items == null) {
      return Wrap(
        children: <Widget>[CircularProgressIndicator()],
      );
    }

    List<FeedItem> filterTops = items.sublist(0, 7);
    return ListView.separated(
        itemBuilder: (context, indexParam) {
          if (indexParam == 0) {
            String title;
            if (items == tops) {
              title = "Hacker Top News";
            } else if (items == newsest) {
              title = "Hacker Lastest News";
            }

            return ListTile(
              title: Text(title),
              trailing: Icon(Icons.keyboard_arrow_right),
            );
          } else {
            var index = --indexParam;

            return ListTile(
              title: Text(filterTops[index].title),
              subtitle: Row(
                children: <Widget>[
                  Text(" by "),
                  Text(filterTops[index].user),
                  Text(" | "),
                  Text(filterTops[index].commentsCount.toString()),
                  Text(" comments"),
                ],
              ),
              onTap: () {
                _launchURL(filterTops[index].url);
              },
            );
          }
        },
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Divider(
              height: 0,
              thickness: 5.0,
            );
          } else {
            return Divider(
              height: 0,
            );
          }
        },
        itemCount: filterTops.length + 1);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
