import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/bloc/bloc_provider.dart';
import 'package:hello_flutter/bloc/count_bloc.dart';
import 'package:hello_flutter/page_three.dart';

class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  CounterBloc _countBloc;

  @override
  Widget build(BuildContext context) {
    _countBloc = BlocProvider.of<CounterBloc>(context);

    return StreamBuilder<int>(
      stream: _countBloc.countSteam,
      initialData: _countBloc.count,
      builder: (context, AsyncSnapshot<int> count) {
        return Scaffold(
          appBar: AppBar(title: Text("Bloc Test Page 2")),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("count:${count.data}"),
                FloatingActionButton(
                  heroTag: 'add',
                  isExtended: true,
                  onPressed: () {
                    _countBloc.increment();
                  },
                  child: Icon(Icons.add),
                ),
                _buildHero()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: 'forward',
            isExtended: true,
            onPressed: () {
              Navigator.of(context)
                  .push(CupertinoPageRoute(builder: (context) {
                return PageThree();
              }));
            },
            child: Icon(Icons.forward),
          ),
        );
      },
    );
  }

  Hero _buildHero() {
    return Hero(
                  tag: 'clear',
                  placeholderBuilder: (context, size, widget) {
                    return Container(height: size.height, width: size.width, child: CircularProgressIndicator(),);
                  },
                  transitionOnUserGestures: true,
                  child: Material(
                      child: IconButton(
                    icon: Icon(Icons.clear),
                  )));
  }
}
