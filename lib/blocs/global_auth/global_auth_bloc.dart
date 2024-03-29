import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';

part 'global_auth_event.dart';
part 'global_auth_state.dart';

class GlobalAuthBloc extends Bloc<GlobalAuthEvent, GlobalAuthState> {
  GlobalAuthBloc() : super(GlobalAuthInitial());

  @override
  Stream<GlobalAuthState> mapEventToState(
    GlobalAuthEvent event,
  ) async* {
    if (event is AppStarted || event is CheckAuthStatus) {
      yield* _mapAppStartedtoState();
    } else if (event is YieldAuthenticatedState) {
      yield* _mapYieldAuthenticatedStateToState(tokens: event.tokens);
    }
  }

  Stream<GlobalAuthState> _mapAppStartedtoState() async* {
    try {
      yield CheckingAuthStatus();
      AuthTokensModel tokens = await LocalDataService().getAuthTokens();
      if (tokens.authenticated) {
        yield Authenticated(tokens: tokens);
      } else {
        yield Unauthenticated();
      }
    } catch (e) {
      yield GlobalAuthError(message: e.toString());
    }
  }

  Stream<GlobalAuthState> _mapYieldAuthenticatedStateToState(
      {required AuthTokensModel tokens}) async* {
    yield Authenticated(tokens: tokens);
  }
}
