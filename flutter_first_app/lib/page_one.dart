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
          body: Center(
            child: Text("count:${count.data}"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _countBloc.increment();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PageTwo();
              }));
            },
            child: Icon(Icons.arrow_forward),
          ),
        );
      },
    );
  }
}
