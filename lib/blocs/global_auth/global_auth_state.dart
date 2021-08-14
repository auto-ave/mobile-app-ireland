part of 'global_auth_bloc.dart';

abstract class GlobalAuthState extends Equatable {
  const GlobalAuthState();
}

class GlobalAuthInitial extends GlobalAuthState {
  @override
  List<Object?> get props => [];
}

class GlobalAuthUninitialized extends GlobalAuthState {
  @override
  String toString() => 'GlobalAuthUninitialized';

  @override
  List<Object> get props => [];
}

class Authenticated extends GlobalAuthState {
  final AuthTokensModel tokens;

  Authenticated({required this.tokens});

  @override
  String toString() => 'Authenticated {tokens: $tokens }';

  @override
  List<Object> get props => [tokens];
}

class Unauthenticated extends GlobalAuthState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

class CheckingAuthStatus extends GlobalAuthState {
  @override
  String toString() => 'Checking Auth Status';

  @override
  List<Object> get props => [];
}

class GlobalAuthError extends GlobalAuthState {
  final String message;
  GlobalAuthError({
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
