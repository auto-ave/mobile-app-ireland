import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("$event BLOC");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("$transition BLOC");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) async {
    Clipboard.setData(ClipboardData(text: error.toString()));
    print("$error BLOC" + bloc.toString());
    await FirebaseCrashlytics.instance
        .recordError(error, StackTrace.current, reason: error);
    super.onError(bloc, error, stackTrace);
  }
}
