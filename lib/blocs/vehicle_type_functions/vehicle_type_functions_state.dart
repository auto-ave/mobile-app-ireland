part of 'vehicle_type_functions_bloc.dart';

abstract class VehicleTypeFunctionsState extends Equatable {
  const VehicleTypeFunctionsState();
}

class VehicleTypeFunctionsInitial extends VehicleTypeFunctionsState {
  @override
  List<Object> get props => [];
}

class VehicleTypeSelectedFunctionsState extends VehicleTypeFunctionsState {
  final VehicleTypeModel vehicleTypeModel;
  VehicleTypeSelectedFunctionsState({
    required this.vehicleTypeModel,
  });
  @override
  List<Object> get props => [vehicleTypeModel];
}

class FailedToSelectVehicleType extends VehicleTypeFunctionsState {
  final String message;
  FailedToSelectVehicleType({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class SelectingVehicleType extends VehicleTypeFunctionsState {
  @override
  List<Object> get props => [];
}
