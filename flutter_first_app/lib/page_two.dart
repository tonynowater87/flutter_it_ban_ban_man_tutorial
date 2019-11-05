import 'package:flutter/material.dart';
import 'package:hello_flutter/bloc/bloc_provider.dart';
import 'package:hello_flutter/bloc/count_bloc.dart';

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
            child: Text("count:${count.data}"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _countBloc.increment();
            },
            child: Icon(Icons.ac_unit),
          ),
        );
      },
    );
  }
}
