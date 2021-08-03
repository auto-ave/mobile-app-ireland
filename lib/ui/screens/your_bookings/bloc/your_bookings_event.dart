part of 'your_bookings_bloc.dart';

abstract class YourBookingsEvent extends Equatable {
  const YourBookingsEvent();
}

class GetYourBookings extends YourBookingsEvent {
  final int offset;
  GetYourBookings({
    required this.offset,
  });
  @override
  List<Object?> get props => [];
}
