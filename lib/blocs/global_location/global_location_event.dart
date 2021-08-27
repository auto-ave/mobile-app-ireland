part of 'global_location_bloc.dart';

abstract class GlobalLocationEvent extends Equatable {
  const GlobalLocationEvent();

  @override
  List<Object> get props => [];
}

class SetUserLocation extends GlobalLocationEvent {
  final LocationModel location;
  SetUserLocation({
    required this.location,
  });
}

class YieldLocationPermissionError extends GlobalLocationEvent {
  final LocationPermission permission;
  YieldLocationPermissionError({
    required this.permission,
  });
}

class YieldLocationServiceError extends GlobalLocationEvent {}

class GetCurrentUserLocation extends GlobalLocationEvent {
  @override
  List<Object> get props => [];
}
