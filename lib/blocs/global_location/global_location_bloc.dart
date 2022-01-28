import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:themotorwash/data/models/city.dart';
import 'package:themotorwash/data/models/location_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'global_location_event.dart';
part 'global_location_state.dart';

class GlobalLocationBloc
    extends Bloc<GlobalLocationEvent, GlobalLocationState> {
  final Repository _repository;
  GlobalLocationBloc({required Repository repository})
      : _repository = repository,
        super(LocationUninitialized());

  @override
  Stream<GlobalLocationState> mapEventToState(
    GlobalLocationEvent event,
  ) async* {
    if (event is GetCurrentUserLocation) {
      yield* _mapGetCurrentUserLocationToState();
    } else if (event is SetUserLocation) {
      yield* _mapSetUserLocationToState(location: event.location);
    } else if (event is SkipUserLocation) {
      yield* _mapSkipUserLocationToState();
    }
  }

  Stream<GlobalLocationState> _mapGetCurrentUserLocationToState() async* {
    try {
      yield RetrievingLocation();
      bool serviceEnabled;
      LocationPermission permission;

      // // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        //   // Location services are not enabled don't continue
        //   // accessing the position and request users of the
        //   // App to enable the location services.
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
        // Will throw an expection if permission is denied.
        yield RetrievingLocation();
        List responses = await Future.wait(
            [Geolocator.getCurrentPosition(), _repository.getListOfCities()]);
        Position location = responses[0];
        List<City> cities = responses[1];

        City city = cities[0];
        yield LocationSet(
            location: LocationModel(
                cityCode: city.code,
                cityName: city.name,
                lat: location.latitude,
                long: location.longitude));
      }
    } catch (e) {
      yield GlobalLocationError(message: e.toString());
    }
  }

  Stream<GlobalLocationState> _mapSetUserLocationToState(
      {required LocationModel location}) async* {
    yield LocationSet(location: location);
  }

  Stream<GlobalLocationState> _mapSkipUserLocationToState() async* {
    try {
      yield RetrievingLocation();
      List<City> cities = await _repository.getListOfCities();
      City city = cities[0];

      yield LocationSet(
          location: LocationModel(
              cityCode: city.code,
              cityName: city.name,
              lat: double.parse(city.latitude),
              long: double.parse(city.longitude)));
    } catch (e) {
      yield GlobalLocationError(message: e.toString() + " SKIP NOT WORKING");
    }
  }
}
