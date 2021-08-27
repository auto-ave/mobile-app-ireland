part of 'global_vehicle_type_bloc.dart';

abstract class GlobalVehicleTypeEvent extends Equatable {
  const GlobalVehicleTypeEvent();
}

class CheckSavedVehicleType extends GlobalVehicleTypeEvent {
  @override
  List<Object> get props => [];
}

class YieldSelectedVehicleType extends GlobalVehicleTypeEvent {
  final VehicleTypeModel vehicleType;
  YieldSelectedVehicleType({
    required this.vehicleType,
  });
  @override
  List<Object> get props => [vehicleType];
}
