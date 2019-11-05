import 'dart:async';

import 'package:hello_flutter/bloc/bloc_provider.dart';
import 'package:rxdart/subjects.dart';

//StreamController
/*class CounterBloc extends BaseBloc {
  int _count = 0;

  var _subject = StreamController<int>.broadcast();

  // below code will cause Bad state: Stream has already been listened to.
  // if stream listened by more than one observer
  // var _subject = StreamController<int>();

  Stream<int> get countSteam => _subject.stream;

  int get count => _count;

  increment() {
    _subject.add(++_count);
  }

  @override
  void dispose() {
    print('[Tony] dispose');
    _subject.close();
  }
}*/

// rx
class CounterBloc extends BaseBloc {
  int _count = 0;

  var _subject = BehaviorSubject<int>();

  Stream<int> get countSteam => _subject.stream;

  int get count => _count;

  increment() {
    _subject.add(++_count);
  }

  @override
  void dispose() {
    print('[Tony] dispose');
    _subject.close();
  }
}

// global instance
//CounterBloc counterBloc = CounterBloc();