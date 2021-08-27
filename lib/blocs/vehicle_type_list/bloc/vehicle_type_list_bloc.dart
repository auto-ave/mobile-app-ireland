import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/vehicle_wheel.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';
import 'package:themotorwash/data/models/vehicle_wheel.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'vehicle_type_list_event.dart';
part 'vehicle_type_list_state.dart';

class VehicleTypeListBloc
    extends Bloc<VehicleTypeListEvent, VehicleTypeListState> {
  final Repository _repository;
  VehicleTypeListBloc({required Repository repository})
      : _repository = repository,
        super(VehicleTypeListInitial());

  @override
  Stream<VehicleTypeListState> mapEventToState(
    VehicleTypeListEvent event,
  ) async* {
    if (event is LoadVehicleTypeList) {
      yield* _mapLoadVehicleTypeListToState();
    }
  }

  Stream<VehicleTypeListState> _mapLoadVehicleTypeListToState() async* {
    try {
      yield LoadingVehicleTypeList();
      List<VehicleTypeModel> vehicleTypes =
          await _repository.getVehicleTypeList();
      var isAddedMap = HashMap();
      List<VehicleWheel> wheels = [];
      vehicleTypes.forEach((element) {
        if (!isAddedMap.containsKey(element.wheel)) {
          isAddedMap.putIfAbsent(element.wheel, () => null);
          wheels.add(
              VehicleWheel(wheel: element.wheel, imageUrl: element.image!));
        }
      });

      yield VehicleTypeListLoaded(wheels: wheels, vehicleTypes: vehicleTypes);
    } catch (e) {
      yield FailedToLoadVehicleList(message: e.toString());
    }
  }
}
