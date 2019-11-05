import 'package:flutter/material.dart';
import 'package:hello_flutter/bloc/bloc_provider.dart';
import 'package:hello_flutter/bloc/count_bloc.dart';
import 'package:hello_flutter/page_one.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: CounterBloc(),
      child: MaterialApp(
          title: 'Hello Flutter',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: PageOne()),
    );
  }
}
