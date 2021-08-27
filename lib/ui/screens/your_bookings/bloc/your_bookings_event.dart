part of 'your_bookings_bloc.dart';

abstract class YourBookingsEvent extends Equatable {
  const YourBookingsEvent();
}

class GetYourBookings extends YourBookingsEvent {
  final int offset;
  final bool forLoadMore;
  GetYourBookings({required this.offset, required this.forLoadMore});
  @override
  List<Object?> get props => [offset, forLoadMore];
}
