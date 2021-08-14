part of 'booking_summary_bloc.dart';

abstract class BookingSummaryState extends Equatable {
  const BookingSummaryState();
}

class BookingSummaryInitial extends BookingSummaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class BookingSummaryLoaded extends BookingSummaryState {
  final BookingDetailModel booking;
  BookingSummaryLoaded({
    required this.booking,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [booking];
}

class BookingSummaryError extends BookingSummaryState {
  final String message;
  BookingSummaryError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class BookingSummaryLoading extends BookingSummaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
