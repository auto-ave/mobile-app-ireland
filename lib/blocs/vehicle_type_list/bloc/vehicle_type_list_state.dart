part of 'vehicle_type_list_bloc.dart';

abstract class VehicleListState extends Equatable {
  const VehicleListState();
}

class VehicleListInitial extends VehicleListState {
  @override
  List<Object> get props => [];
}

class VehicleWheelListLoaded extends VehicleListState {
  final List<VehicleWheel> wheels;
  VehicleWheelListLoaded({
    required this.wheels,
  });
  @override
  List<Object> get props => [wheels];
}

class VehicleModelListLoaded extends VehicleListState {
  final List<VehicleModel> vehicles;
  VehicleModelListLoaded({
    required this.vehicles,
  });

  @override
  List<Object> get props => [vehicles];
}

class VehicleBrandListLoaded extends VehicleListState {
  final List<VehicleBrand> brands;
  VehicleBrandListLoaded({
    required this.brands,
  });
  @override
  List<Object> get props => [brands];
}

class VehicleListLoading extends VehicleListState {
  @override
  List<Object> get props => [];
}

class VehicleListError extends VehicleListState {
  final String message;
  VehicleListError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}// class VehicleTypeListLoaded extends VehicleTypeListState {
//   final List<VehicleWheel> wheels;
//   final List<VehicleTypeModel> vehicleTypes;
//   VehicleTypeListLoaded({
//     required this.wheels,
//     required this.vehicleTypes,
//   });
//   @override
//   List<Object> get props => [wheels, vehicleTypes];
// }

// class FailedToLoadVehicleList extends VehicleTypeListState {
//   final String message;
//   FailedToLoadVehicleList({
//     required this.message,
//   });
//   @override
//   List<Object> get props => [message];
// }
