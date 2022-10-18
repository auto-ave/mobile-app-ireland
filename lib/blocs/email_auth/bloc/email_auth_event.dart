part of 'email_auth_bloc.dart';

abstract class EmailAuthEvent extends Equatable {
  const EmailAuthEvent();
}

class AuthenticateEmailAndName extends EmailAuthEvent {
  final String email;
  final String firstName;
  final String lastName;
  AuthenticateEmailAndName(
      {required this.email, required this.firstName, required this.lastName});
  @override
  List<Object> get props => [email, firstName, lastName];
}
