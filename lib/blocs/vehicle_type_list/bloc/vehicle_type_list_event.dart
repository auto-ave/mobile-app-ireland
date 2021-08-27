part of 'vehicle_type_list_bloc.dart';

abstract class VehicleTypeListEvent extends Equatable {
  const VehicleTypeListEvent();
}

class LoadVehicleTypeList extends VehicleTypeListEvent {
  @override
  List<Object> get props => [];
}
