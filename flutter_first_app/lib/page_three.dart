import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/bloc/global_bloc.dart';

class PageThree extends StatefulWidget {
  PageThree({Key key}) : super(key: key);

  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: globalBloc.stream,
      initialData: "",
      builder: (context, AsyncSnapshot<String> string) {
        return Scaffold(
          appBar: AppBar(title: Text("Bloc Test Page 2")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("stream:${string.data}"),
                FloatingActionButton(
                  heroTag: 'forward',
                  isExtended: true,
                  onPressed: () {
                    globalBloc.push(Random(DateTime.now().millisecond).nextInt(100).toString());
                  },
                  child: Icon(Icons.navigate_next),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
