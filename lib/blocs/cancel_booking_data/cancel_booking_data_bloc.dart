import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/cancel_booking_data.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'cancel_booking_data_event.dart';
part 'cancel_booking_data_state.dart';

class CancelBookingDataBloc
    extends Bloc<CancelBookingDataEvent, CancelBookingDataState> {
  final Repository _repository;
  CancelBookingDataBloc({required Repository repository})
      : _repository = repository,
        super(CancelBookingDataInitial()) {
    on<CancelBookingDataEvent>((event, emit) async {
      if (event is GetCancelBookingData) {
        await _mapGetCancelBookingDataToState(
            bookingId: event.bookingId, emit: emit);
      }
    });
  }

  FutureOr<void> _mapGetCancelBookingDataToState(
      {required String bookingId,
      required Emitter<CancelBookingDataState> emit}) async {
    try {
      emit(CancelBookingDataLoading());
      CancelBookingData data =
          await _repository.getCancelBookingData(bookingId: bookingId);
      emit(CancelBookingDataLoaded(data: data));
    } catch (e) {
      emit(CancelBookingDataError(message: e.toString()));
    }
  }
}
