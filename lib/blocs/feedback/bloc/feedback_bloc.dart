import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final Repository _repository;
  FeedbackBloc({required Repository repository})
      : _repository = repository,
        super(FeedbackInitial());

  @override
  Stream<FeedbackState> mapEventToState(
    FeedbackEvent event,
  ) async* {
    if (event is SendFeedback) {
      yield* _mapSendFeedbackToState(
          email: event.email, message: event.message, phoneNumber: event.phone);
    }
  }

  Stream<FeedbackState> _mapSendFeedbackToState(
      {required String phoneNumber,
      required String email,
      required String message}) async* {
    try {
      yield FeedbackLoading();
      await _repository.sendFeedback(
          email: email, phoneNumber: phoneNumber, message: message);
      yield FeedbackSent();
    } catch (e) {
      yield FeedbackError(message: e.toString());
    }
  }
}
