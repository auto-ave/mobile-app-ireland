part of 'phone_auth_bloc.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();
}

class SendOTP extends PhoneAuthEvent {
  final String phoneNumber;

  SendOTP({required this.phoneNumber});
  @override
  // TODO: implement props
  List<Object?> get props => [phoneNumber];
}

class CheckOTP extends PhoneAuthEvent {
  final String otp;
  final String phoneNumber;

  CheckOTP({required this.otp, required this.phoneNumber});
  @override
  // TODO: implement props
  List<Object?> get props => [otp, phoneNumber];
}

class LogOut extends PhoneAuthEvent {
  LogOut();

  @override
  List<Object?> get props => [];
}
