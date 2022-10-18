import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'vehicle_details_reg_event.dart';
part 'vehicle_details_reg_state.dart';

class VehicleDetailsRegBloc
    extends Bloc<VehicleDetailsRegEvent, VehicleDetailsRegState> {
  final Repository _repository;
  VehicleDetailsRegBloc({required Repository repository})
      : _repository = repository,
        super(VehicleDetailsRegInitial()) {
    on<VehicleDetailsRegEvent>((event, emit) async {
      if (event is GetVehicleDetailsByRegNo) {
        await _mapGetVehicleDetailsByRegNoToState(
            vehicleNum: event.vehicleNum, emit: emit);
      }
    });
  }

  FutureOr<void> _mapGetVehicleDetailsByRegNoToState(
      {required String vehicleNum,
      required Emitter<VehicleDetailsRegState> emit}) async {
    try {
      emit(VehicleDetailsRegLoading());
      VehicleModel vehicle =
          await _repository.getVehicleFromRegNo(vehicleNum: vehicleNum);
      emit(VehicleDetailsRegLoaded(vehicleModel: vehicle));
    } catch (e) {
      emit(VehicleDetailsRegError(message: e.toString()));
    }
  }
}
