part of 'email_auth_bloc.dart';

abstract class EmailAuthState extends Equatable {
  const EmailAuthState();
}

class EmailAuthInitial extends EmailAuthState {
  @override
  List<Object> get props => [];
}

class EmailAuthLoading extends EmailAuthState {
  @override
  List<Object> get props => [];
}

class EmailAuthenticated extends EmailAuthState {
  final AuthTokensModel tokens;
  EmailAuthenticated({
    required this.tokens,
  });
  @override
  List<Object> get props => [tokens];
}

class EmailAuthError extends EmailAuthState {
  final String message;
  EmailAuthError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
