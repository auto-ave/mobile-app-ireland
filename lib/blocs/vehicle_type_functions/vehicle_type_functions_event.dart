part of 'vehicle_type_functions_bloc.dart';

abstract class VehicleTypeFunctionsEvent extends Equatable {
  const VehicleTypeFunctionsEvent();
}

class SelectVehicleType extends VehicleTypeFunctionsEvent {
  final VehicleTypeModel vehicleTypeModel;
  SelectVehicleType({
    required this.vehicleTypeModel,
  });
  @override
  List<Object> get props => [vehicleTypeModel];
}
