part of 'global_auth_bloc.dart';

abstract class GlobalAuthEvent extends Equatable {
  const GlobalAuthEvent();
}

class AppStarted extends GlobalAuthEvent {
  @override
  List<Object?> get props => [];
}

class CheckAuthStatus extends GlobalAuthEvent {
  @override
  List<Object?> get props => [];
}

class YieldAuthenticatedState extends GlobalAuthEvent {
  final AuthTokensModel tokens;
  YieldAuthenticatedState({
    required this.tokens,
  });
  @override
  List<Object?> get props => [tokens];
}
