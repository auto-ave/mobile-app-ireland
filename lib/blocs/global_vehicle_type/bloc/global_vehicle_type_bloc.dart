import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';

part 'global_vehicle_type_event.dart';
part 'global_vehicle_type_state.dart';

class GlobalVehicleTypeBloc
    extends Bloc<GlobalVehicleTypeEvent, GlobalVehicleTypeState> {
  final LocalDataService _localDataService;
  GlobalVehicleTypeBloc({required LocalDataService localDataService})
      : _localDataService = localDataService,
        super(GlobalVehicleTypeInitial());

  @override
  Stream<GlobalVehicleTypeState> mapEventToState(
    GlobalVehicleTypeEvent event,
  ) async* {
    if (event is CheckSavedVehicleType) {
      yield* _mapCheckSelectedVehicleTypeToState();
    } else if (event is YieldSelectedVehicleType) {
      yield* _mapYieldSelectedVehicleTypeToState(
          vehicleTypeModel: event.vehicleType);
    }
  }

  Stream<GlobalVehicleTypeState> _mapCheckSelectedVehicleTypeToState() async* {
    try {
      yield CheckingSavedVehicleType();

      VehicleTypeModel? vehicleTypeSelected =
          await _localDataService.getSavedVehicleType();
      if (vehicleTypeSelected == null) {
        yield VehicleTypeNotSelected();
      } else {
        yield GlobalVehicleTypeSelected(vehicleTypeModel: vehicleTypeSelected);
      }
    } catch (e) {
      yield GlobalVehicleTypeError(message: e.toString());
    }
  }

  Stream<GlobalVehicleTypeState> _mapYieldSelectedVehicleTypeToState(
      {required VehicleTypeModel vehicleTypeModel}) async* {
    yield GlobalVehicleTypeSelected(vehicleTypeModel: vehicleTypeModel);
  }
}
