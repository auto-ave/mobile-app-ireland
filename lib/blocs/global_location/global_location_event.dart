part of 'global_location_bloc.dart';

abstract class GlobalLocationEvent extends Equatable {
  const GlobalLocationEvent();
}

class SetUserLocation extends GlobalLocationEvent {
  final LocationModel location;
  SetUserLocation({
    required this.location,
  });
  @override
  List<Object> get props => [location];
}

class SkipUserLocation extends GlobalLocationEvent {
  @override
  List<Object> get props => [];
}

class YieldLocationPermissionError extends GlobalLocationEvent {
  final LocationPermission permission;
  YieldLocationPermissionError({
    required this.permission,
  });
  @override
  List<Object> get props => [permission];
}

class YieldLocationServiceError extends GlobalLocationEvent {
  @override
  List<Object> get props => [];
}

class GetCurrentUserLocation extends GlobalLocationEvent {
  @override
  List<Object> get props => [];
}
