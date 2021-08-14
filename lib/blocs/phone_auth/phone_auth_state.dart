part of 'phone_auth_bloc.dart';

@immutable
abstract class PhoneAuthState extends Equatable {
  const PhoneAuthState();
}

class PhoneAuthUninitialized extends PhoneAuthState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class PhoneAuthenticated extends PhoneAuthState {
  final AuthTokensModel tokens;

  PhoneAuthenticated(this.tokens);

  @override
  String toString() => 'PhoneAuthenticated { tokens: ${tokens} }';

  @override
  List<Object> get props => [tokens];
}

class SendingOTP extends PhoneAuthState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class OTPSent extends PhoneAuthState {
  @override
  List<Object?> get props => [];
}

class FailedToSendOTP extends PhoneAuthState {
  final String message;
  FailedToSendOTP({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CheckingOTP extends PhoneAuthState {
  @override
  List<Object?> get props => [];
}

class OTPCheckedPassed extends PhoneAuthState {
  final AuthTokensModel tokens;
  OTPCheckedPassed({
    required this.tokens,
  });
  @override
  List<Object?> get props => [tokens];
}

class OTPCheckFailed extends PhoneAuthState {
  final String message;
  OTPCheckFailed({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class PhoneAuthLoading extends PhoneAuthState {
  @override
  List<Object?> get props => [];
}

class PhoneAuthError extends PhoneAuthState {
  final String message;
  PhoneAuthError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
