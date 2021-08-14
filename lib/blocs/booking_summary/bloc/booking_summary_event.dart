part of 'booking_summary_bloc.dart';

abstract class BookingSummaryEvent extends Equatable {
  const BookingSummaryEvent();
}

class GetBookingSummary extends BookingSummaryEvent {
  final String bookingId;
  GetBookingSummary({
    required this.bookingId,
  });

  @override
  List<Object?> get props => [bookingId];
}
