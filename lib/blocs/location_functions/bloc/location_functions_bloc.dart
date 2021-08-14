import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_functions_event.dart';
part 'location_functions_state.dart';

class LocationFunctionsBloc
    extends Bloc<LocationFunctionsEvent, LocationFunctionsState> {
  LocationFunctionsBloc() : super(LocationFunctionsInitial());

  @override
  Stream<LocationFunctionsState> mapEventToState(
    LocationFunctionsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetListOfCities) {
      yield* _mapGetListOfCitiesToState();
    } else if (event is GetCurrentUserLocation) {
      yield* _mapGetCurrentUserLocationToState();
    }
  }

  Stream<LocationFunctionsState> _mapGetListOfCitiesToState() async* {}

  Stream<LocationFunctionsState> _mapGetCurrentUserLocationToState() async* {}
}
