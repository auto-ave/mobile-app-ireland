import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/data/local/local_auth_service.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/models/send_otp_response.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  AuthRepository _repository;
  GlobalAuthBloc _globalAuthBloc;
  PhoneAuthBloc(
      {required AuthRepository repository,
      required GlobalAuthBloc globalAuthBloc})
      : _repository = repository,
        _globalAuthBloc = globalAuthBloc,
        super(PhoneAuthUninitialized());

  @override
  Stream<PhoneAuthState> mapEventToState(
    PhoneAuthEvent event,
  ) async* {
    if (event is SendOTP) {
      yield* _mapSendOTPtoState(
        phoneNumber: event.phoneNumber,
      );
    } else if (event is CheckOTP) {
      yield* _mapCheckOTPtoState(
          otp: event.otp, phoneNumber: event.phoneNumber);
    }
  }

  Stream<PhoneAuthState> _mapSendOTPtoState(
      {required String phoneNumber}) async* {
    try {
      yield SendingOTP();
      SendOTPResponse otpSent =
          await _repository.sendOTP(phoneNumber: phoneNumber);
      yield otpSent.isOTPSent
          ? OTPSent()
          : FailedToSendOTP(message: otpSent.message!);
    } catch (e) {
      yield FailedToSendOTP(message: e.toString());
    }
  }

  Stream<PhoneAuthState> _mapCheckOTPtoState(
      {required String otp, required String phoneNumber}) async* {
    try {
      yield CheckingOTP();
      print('checking otp');
      AuthTokensModel tokens =
          await _repository.checkOTP(phoneNumber: phoneNumber, otp: otp);
      if (tokens.authenticated) {
        _globalAuthBloc.add(YieldAuthenticatedState(tokens: tokens));
      }
      await LocalAuthService().storeAuthToken(tokens);

      yield tokens.authenticated
          ? OTPCheckedPassed(tokens: tokens)
          : OTPCheckFailed(message: 'Wrong OTP entered');
    } catch (e) {
      yield OTPCheckFailed(message: e.toString());
    }
  }
}
