import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'booking_summary_event.dart';
part 'booking_summary_state.dart';

class BookingSummaryBloc
    extends Bloc<BookingSummaryEvent, BookingSummaryState> {
  final Repository _repository;
  BookingSummaryBloc({required Repository repository})
      : _repository = repository,
        super(BookingSummaryInitial());

  @override
  Stream<BookingSummaryState> mapEventToState(
    BookingSummaryEvent event,
  ) async* {
    if (event is GetBookingSummary) {
      yield* _mapGetBookingSummaryTostate(bookingId: event.bookingId);
    }
  }

  Stream<BookingSummaryState> _mapGetBookingSummaryTostate(
      {required String bookingId}) async* {
    try {
      yield BookingSummaryLoading();
      BookingDetailModel booking =
          await _repository.getBookingDetail(bookingId: bookingId);
      yield BookingSummaryLoaded(booking: booking);
    } catch (e) {
      yield BookingSummaryError(message: e.toString());
    }
  }
}
