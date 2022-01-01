import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'dart:async';
part 'cancel_booking_request_event.dart';
part 'cancel_booking_request_state.dart';

class CancelBookingRequestBloc
    extends Bloc<CancelBookingRequestEvent, CancelBookingRequestState> {
  final Repository _repository;
  CancelBookingRequestBloc({required Repository repository})
      : _repository = repository,
        super(CancelBookingRequestInitial()) {
    on<CancelBookingRequestEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SubmitCancelBookingRequest) {
        await _mapSubmitCancelRequestToState(
            bookingId: event.bookingId, reason: event.reason, emit: emit);
      }
    });
  }
  FutureOr<void> _mapSubmitCancelRequestToState(
      {required String bookingId,
      required String reason,
      required Emitter<CancelBookingRequestState> emit}) async {
    try {
      emit(CancelBookingRequestLoading());
      await _repository.cancelBooking(bookingId: bookingId, reason: reason);
      emit(CancelBookingRequestSuccess());
    } catch (e) {
      emit(CancelBookingRequestError(message: e.toString()));
    }
  }
}
