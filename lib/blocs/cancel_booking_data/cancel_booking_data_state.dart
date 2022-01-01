part of 'cancel_booking_data_bloc.dart';

abstract class CancelBookingDataState extends Equatable {
  const CancelBookingDataState();
}

class CancelBookingDataInitial extends CancelBookingDataState {
  @override
  List<Object> get props => [];
}

class CancelBookingDataLoading extends CancelBookingDataState {
  @override
  List<Object> get props => [];
}

class CancelBookingDataError extends CancelBookingDataState {
  final String message;
  CancelBookingDataError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class CancelBookingDataLoaded extends CancelBookingDataState {
  final CancelBookingData data;
  CancelBookingDataLoaded({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}
