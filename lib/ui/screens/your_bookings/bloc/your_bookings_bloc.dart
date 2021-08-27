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
      yield* _mapGetYourBookingToState(
          offset: event.offset, forLoadMore: event.forLoadMore);
    }
  }

  bool hasReachedMax(YourBookingsState state) =>
      state is YourBookingsLoaded && state.hasReachedMax;

  Stream<YourBookingsState> _mapGetYourBookingToState(
      {required int offset, required bool forLoadMore}) async* {
    if (!hasReachedMax(state)) {
      print("hellobook");
      try {
        List<BookingListModel> bookings = [];
        if (state is YourBookingsLoaded && forLoadMore) {
          yield MoreYourBookingsLoading();
          bookings = (state as YourBookingsLoaded).bookings;
        } else {
          yield YourBookingsLoading();
        }

        List<BookingListModel> moreBookings =
            await _repository.getYourBookings(offset: offset);
        yield YourBookingsLoaded(
            bookings: bookings + moreBookings,
            hasReachedMax:
                moreBookings.length != 10); //page limit in apiconstants is 10
      } catch (e) {
        yield YourBookingsError(message: e.toString());
      }
    }
  }
}
