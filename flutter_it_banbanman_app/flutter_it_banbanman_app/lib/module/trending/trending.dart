import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_it_banbanman_app/module/trending/trending_developer.dart';
import 'package:flutter_it_banbanman_app/module/trending/trending_project.dart';

enum TrendingDateRange { Daily, Weekly, Monthly }

class TrendingPage extends StatefulWidget {
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  TrendingDateRange _dateRange = TrendingDateRange.Daily;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(),
            title: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[Tab(text: "Project"), Tab(text: "Developer")],
            ),
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<TrendingDateRange>(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.date_range),
                          SizedBox(width: 8,),
                          Text("Date range")
                        ],
                      ),
                    ),
                    CheckedPopupMenuItem<TrendingDateRange>(
                      child: Text("daily"),
                      value: TrendingDateRange.Daily,
                      checked: _dateRange == TrendingDateRange.Daily,
                    ),
                    CheckedPopupMenuItem<TrendingDateRange>(
                      child: Text("weekly"),
                      value: TrendingDateRange.Weekly,
                      checked: _dateRange == TrendingDateRange.Weekly,
                    ),
                    CheckedPopupMenuItem<TrendingDateRange>(
                      child: Text("monthly"),
                      value: TrendingDateRange.Monthly,
                      checked: _dateRange == TrendingDateRange.Monthly,
                    )
                  ];
                },
                onSelected: (TrendingDateRange value) {
                  setState(() {
                    print('[Tony] select:$value');
                    _dateRange = value;
                  });
                },
              )
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              TrendingProjectPage(dateRange:_dateRange),
              TrendingDeveloperPage(dateRange: _dateRange,),
            ],
          ),
        ));
  }
}