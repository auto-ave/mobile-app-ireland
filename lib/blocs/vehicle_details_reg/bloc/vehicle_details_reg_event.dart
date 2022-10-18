part of 'vehicle_details_reg_bloc.dart';

abstract class VehicleDetailsRegEvent extends Equatable {
  const VehicleDetailsRegEvent();

  @override
  List<Object> get props => [];
}

class GetVehicleDetailsByRegNo extends VehicleDetailsRegEvent {
  final String vehicleNum;
  GetVehicleDetailsByRegNo({
    required this.vehicleNum,
  });
  @override
  List<Object> get props => [];
}
