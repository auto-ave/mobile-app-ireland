part of 'cancel_booking_data_bloc.dart';

abstract class CancelBookingDataEvent extends Equatable {
  const CancelBookingDataEvent();
}

class GetCancelBookingData extends CancelBookingDataEvent {
  final String bookingId;
  GetCancelBookingData({
    required this.bookingId,
  });
  @override
  List<Object> get props => [];
}
