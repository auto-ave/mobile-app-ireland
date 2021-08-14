part of 'location_functions_bloc.dart';

abstract class LocationFunctionsEvent extends Equatable {
  const LocationFunctionsEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUserLocation extends LocationFunctionsEvent {}

class GetListOfCities extends LocationFunctionsEvent {}
