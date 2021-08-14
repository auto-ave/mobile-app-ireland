part of 'location_functions_bloc.dart';

abstract class LocationFunctionsState extends Equatable {
  const LocationFunctionsState();
}

class LocationFunctionsInitial extends LocationFunctionsState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class CurrentUserLocationRetrieved extends LocationFunctionsState {
  final double latitude;
  final double longitude;
  CurrentUserLocationRetrieved({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props => [latitude, longitude];
}

class ListOfCitiesRetrieved extends LocationFunctionsState {
  final List<String> cities;
  ListOfCitiesRetrieved({
    required this.cities,
  });

  @override
  List<Object?> get props => [cities];
}

class FailedToLoadCitiesError extends LocationFunctionsState {
  final String message;
  FailedToLoadCitiesError({
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class FailedToRetrieveUserLocationError extends LocationFunctionsState {
  final String message;
  FailedToRetrieveUserLocationError({
    required this.message,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
