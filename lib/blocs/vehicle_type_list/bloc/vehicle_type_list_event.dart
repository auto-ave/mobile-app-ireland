part of 'vehicle_type_list_bloc.dart';

abstract class VehicleListEvent extends Equatable {
  const VehicleListEvent();
}

class LoadVehicleTypeList extends VehicleListEvent {
  @override
  List<Object> get props => [];
}

class LoadVehicleWheelList extends VehicleListEvent {
  @override
  List<Object> get props => [];
}

class LoadVehicleBrandList extends VehicleListEvent {
  final String wheelCode;
  LoadVehicleBrandList({
    required this.wheelCode,
  });
  @override
  List<Object> get props => [wheelCode];
}

class LoadVehicleModelList extends VehicleListEvent {
  final String brand;
  LoadVehicleModelList({
    required this.brand,
  });

  @override
  List<Object> get props => [brand];
}
