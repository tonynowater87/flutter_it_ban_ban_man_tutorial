import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/bloc/bloc_provider.dart';
import 'package:hello_flutter/bloc/count_bloc.dart';
import 'package:hello_flutter/page_two.dart';

class PageOne extends StatefulWidget {
  PageOne({Key key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  CounterBloc _countBloc;

  @override
  Widget build(BuildContext context) {
    _countBloc = BlocProvider.of(context);
    return StreamBuilder<int>(
      stream: _countBloc.countSteam,
      initialData: _countBloc.count,
      builder: (context, AsyncSnapshot<int> count) {
        return Scaffold(
          appBar: AppBar(title: Text("Bloc Test Page 1")),
          body: Container(
            child: Column(
              children: <Widget>[
                Text("count:${count.data}"),
                FloatingActionButton(
                  heroTag: 'forward',
                  onPressed: () {
                    _countBloc.increment();
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return PageTwo();
                    }));
                  },
                  child: Icon(Icons.forward),
                ),
                _buildHero()
              ],
            ),
          ),
        );
      },
    );
  }

  Hero _buildHero() {
    return Hero(
                tag: 'clear',
                transitionOnUserGestures: true,
                // ignore: missing_return
                flightShuttleBuilder: (flightContext, animation, direction,
                    fromContext, toContext) {
                  if(direction == HeroFlightDirection.push) { //出發
                    return Icon(
                      Icons.flash_on,
                      size: 50.0,
                    );
                  } else if (direction == HeroFlightDirection.pop){ //回程
                    return Icon(
                      Icons.flash_on,
                      size: 500.0,
                    );
                  }
                },
                child: Material(
                    child: IconButton(
                  icon: Icon(Icons.clear,size: 80,),
                )),
              );
  }
}
