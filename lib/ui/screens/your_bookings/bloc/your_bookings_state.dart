part of 'your_bookings_bloc.dart';

abstract class YourBookingsState extends Equatable {
  const YourBookingsState();
}

class YourBookingsInitial extends YourBookingsState {
  @override
  List<Object?> get props => [];
}

class YourBookingsLoaded extends YourBookingsState {
  final List<BookingListModel> bookings;
  final bool hasReachedMax;
  YourBookingsLoaded({required this.bookings, required this.hasReachedMax});

  @override
  List<Object?> get props => [bookings];
}

class YourBookingsLoading extends YourBookingsState {
  @override
  List<Object?> get props => [];
}

class MoreYourBookingsLoading extends YourBookingsState {
  @override
  List<Object?> get props => [];
}

class YourBookingsError extends YourBookingsState {
  final String message;
  YourBookingsError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
