part of 'cancel_booking_request_bloc.dart';

abstract class CancelBookingRequestEvent extends Equatable {
  const CancelBookingRequestEvent();
}

class SubmitCancelBookingRequest extends CancelBookingRequestEvent {
  final String reason;
  final String bookingId;
  SubmitCancelBookingRequest({required this.reason, required this.bookingId});
  @override
  List<Object> get props => [reason, bookingId];
}
