part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationUninitialized extends LocationState {}

class LocationSelected extends LocationState {}
