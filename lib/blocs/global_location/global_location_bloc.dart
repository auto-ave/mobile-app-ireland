import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:themotorwash/data/models/location_model.dart';

part 'global_location_event.dart';
part 'global_location_state.dart';

class GlobalLocationBloc
    extends Bloc<GlobalLocationEvent, GlobalLocationState> {
  GlobalLocationBloc() : super(LocationUninitialized());

  @override
  Stream<GlobalLocationState> mapEventToState(
    GlobalLocationEvent event,
  ) async* {
    if (event is GetCurrentUserLocation) {
      yield* _mapGetCurrentUserLocationToState();
    } else if (event is SetUserLocation) {
      yield* _mapSetUserLocationToState(location: event.location);
    }
  }

  Stream<GlobalLocationState> _mapGetCurrentUserLocationToState() async* {
    try {
      yield RetrievingLocation();
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        yield LocationServiceNotEnabledError();
      } else {
        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          yield LocationPermissionError(locationPermission: permission);
        } else if (permission == LocationPermission.deniedForever) {
          yield LocationPermissionError(locationPermission: permission);
        }

        // When we reach here, permissions are granted and we can
        // continue accessing the position of the device.
        Position location = await Geolocator.getCurrentPosition();
        yield LocationSet(
            location: LocationModel(
                city: '462001',
                lat: location.latitude,
                long: location.longitude));
      }
    } catch (e) {
      GlobalLocationError(message: e.toString());
    }
  }

  Stream<GlobalLocationState> _mapSetUserLocationToState(
      {required LocationModel location}) async* {
    yield LocationSet(location: location);
  }
}
