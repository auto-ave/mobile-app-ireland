import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';
import 'package:themotorwash/utils/utils.dart';

part 'email_auth_event.dart';
part 'email_auth_state.dart';

class EmailAuthBloc extends Bloc<EmailAuthEvent, EmailAuthState> {
  AuthRepository _repository;
  GlobalAuthBloc _globalAuthBloc;
  FirebaseMessaging _fcmInstance;
  LocalDataService _localDataService;
  EmailAuthBloc(
      {required AuthRepository repository,
      required GlobalAuthBloc globalAuthBloc,
      required FirebaseMessaging fcmInstance,
      required LocalDataService localDataService})
      : _repository = repository,
        _globalAuthBloc = globalAuthBloc,
        _fcmInstance = fcmInstance,
        _localDataService = localDataService,
        super(EmailAuthInitial()) {
    on<EmailAuthEvent>((event, emit) async {
      // TODO: implement event handler

      if (event is AuthenticateEmailAndName) {
        await _mapAuthenticateEmailAndNameToState(
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            emit: emit);
      }
    });
  }

  FutureOr<void> _mapAuthenticateEmailAndNameToState(
      {required String firstName,
      required String lastName,
      required String email,
      required Emitter<EmailAuthState> emit}) async {
    try {
      emit(EmailAuthLoading());
      String? token = await _fcmInstance.getToken();
      //TODO

      AuthTokensModel tokens = await _repository.authenticateEmailAndName(
          firstName: firstName,
          lastName: lastName,
          email: email,
          token: token ?? '');
      await _localDataService.storeAuthToken(tokens);
      tokens.authenticated
          ? emit(EmailAuthenticated(tokens: tokens))
          : emit(EmailAuthError(message: 'Something went wrong'));
      if (tokens.authenticated) {
        try {
          // mixpanel?.identify(
          //   phoneNumber,
          // );

          await FlutterUxcam.setUserIdentity(email);
        } on Exception catch (e) {
          autoaveLog(e.toString());
        }

        _globalAuthBloc.add(YieldAuthenticatedState(tokens: tokens));
      }
    } catch (e) {
      emit(EmailAuthError(message: 'Something went wrong'));
    }
  }
}
