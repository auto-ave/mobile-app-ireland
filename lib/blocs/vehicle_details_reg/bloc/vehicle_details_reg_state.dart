part of 'vehicle_details_reg_bloc.dart';

abstract class VehicleDetailsRegState extends Equatable {
  const VehicleDetailsRegState();
}

class VehicleDetailsRegInitial extends VehicleDetailsRegState {
  @override
  List<Object> get props => [];
}

class VehicleDetailsRegLoading extends VehicleDetailsRegState {
  @override
  List<Object> get props => [];
}

class VehicleDetailsRegLoaded extends VehicleDetailsRegState {
  final VehicleModel vehicleModel;
  VehicleDetailsRegLoaded({
    required this.vehicleModel,
  });
  @override
  List<Object> get props => [vehicleModel];
}

class VehicleDetailsRegError extends VehicleDetailsRegState {
  final String message;
  VehicleDetailsRegError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
