part of 'vehicle_type_list_bloc.dart';

abstract class VehicleTypeListState extends Equatable {
  const VehicleTypeListState();
}

class VehicleTypeListInitial extends VehicleTypeListState {
  @override
  List<Object> get props => [];
}

class LoadingVehicleTypeList extends VehicleTypeListState {
  @override
  List<Object> get props => [];
}

class VehicleTypeListLoaded extends VehicleTypeListState {
  final List<VehicleWheel> wheels;
  final List<VehicleTypeModel> vehicleTypes;
  VehicleTypeListLoaded({
    required this.wheels,
    required this.vehicleTypes,
  });
  @override
  List<Object> get props => [wheels, vehicleTypes];
}

class FailedToLoadVehicleList extends VehicleTypeListState {
  final String message;
  FailedToLoadVehicleList({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
