import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {

  final bool DEBUG = false;

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    if (DEBUG) {
      print('[Bloc] onEvent:$event');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (DEBUG) {
      print('[Bloc] onTransition:$transition');
    }
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    if (DEBUG) {
      print('[Bloc] onError:$error');
    }
  }
}