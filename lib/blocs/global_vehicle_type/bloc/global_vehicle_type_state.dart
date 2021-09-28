part of 'global_vehicle_type_bloc.dart';

abstract class GlobalVehicleTypeState extends Equatable {
  const GlobalVehicleTypeState();
}

class GlobalVehicleTypeInitial extends GlobalVehicleTypeState {
  @override
  List<Object> get props => [];
}

class CheckingSavedVehicleType extends GlobalVehicleTypeState {
  @override
  List<Object> get props => [];
}

class GlobalVehicleTypeSelected extends GlobalVehicleTypeState {
  final VehicleModel vehicleTypeModel;
  GlobalVehicleTypeSelected({
    required this.vehicleTypeModel,
  });
  @override
  List<Object> get props => [vehicleTypeModel];
}

class VehicleTypeNotSelected extends GlobalVehicleTypeState {
  @override
  List<Object> get props => [];
}

class GlobalVehicleTypeError extends GlobalVehicleTypeState {
  final String message;
  GlobalVehicleTypeError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
