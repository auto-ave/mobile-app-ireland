part of 'global_location_bloc.dart';

abstract class GlobalLocationState extends Equatable {
  const GlobalLocationState();
}

class LocationUninitialized extends GlobalLocationState {
  @override
  List<Object?> get props => [];
}

class LocationSet extends GlobalLocationState {
  final LocationModel location;
  LocationSet({
    required this.location,
  });
  @override
  List<Object?> get props => [location];
}

class LocationServiceNotEnabledError extends GlobalLocationState {
  @override
  List<Object?> get props => [];
}

class LocationPermissionError extends GlobalLocationState {
  final LocationPermission locationPermission;
  LocationPermissionError({
    required this.locationPermission,
  });

  @override
  List<Object?> get props => [locationPermission];
}

class GlobalLocationError extends GlobalLocationState {
  final String message;
  GlobalLocationError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class RetrievingLocation extends GlobalLocationState {
  @override
  List<Object?> get props => [];
}
