part of 'cancel_booking_request_bloc.dart';

abstract class CancelBookingRequestState extends Equatable {
  const CancelBookingRequestState();
}

class CancelBookingRequestInitial extends CancelBookingRequestState {
  @override
  List<Object> get props => [];
}

class CancelBookingRequestLoading extends CancelBookingRequestState {
  @override
  List<Object> get props => [];
}

class CancelBookingRequestError extends CancelBookingRequestState {
  final String message;
  CancelBookingRequestError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class CancelBookingRequestSuccess extends CancelBookingRequestState {
  @override
  List<Object> get props => [];
}
