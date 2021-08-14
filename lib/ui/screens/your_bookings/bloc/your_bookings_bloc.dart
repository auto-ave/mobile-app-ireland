import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'your_bookings_event.dart';
part 'your_bookings_state.dart';

class YourBookingsBloc extends Bloc<YourBookingsEvent, YourBookingsState> {
  Repository _repository;
  YourBookingsBloc({required Repository repository})
      : _repository = repository,
        super(YourBookingsInitial());

  @override
  Stream<YourBookingsState> mapEventToState(
    YourBookingsEvent event,
  ) async* {
    if (event is GetYourBookings) {
      yield* _mapGetYourBookingToState(offset: event.offset);
    }
  }

  bool _hasReachedMax(YourBookingsState state) =>
      state is YourBookingsLoaded && state.hasReachedMax;

  Stream<YourBookingsState> _mapGetYourBookingToState(
      {required int offset}) async* {
    if (!_hasReachedMax(state)) {
      try {
        if (state is YourBookingsLoaded) {
          yield YourBookingsLoading();
        }
        List<BookingListModel> bookings = state is YourBookingsLoaded
            ? (state as YourBookingsLoaded).bookings
            : [];

        List<BookingListModel> moreBookings =
            await _repository.getYourBookings(offset: offset);
        yield YourBookingsLoaded(
            bookings: bookings + moreBookings,
            hasReachedMax: moreBookings.isEmpty);
      } catch (e) {
        yield YourBookingsError(message: e.toString());
      }
    }
  }
}
