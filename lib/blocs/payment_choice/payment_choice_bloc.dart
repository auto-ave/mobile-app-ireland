import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/payment_choice.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'payment_choice_event.dart';
part 'payment_choice_state.dart';

class PaymentChoiceBloc extends Bloc<PaymentChoiceEvent, PaymentChoiceState> {
  final Repository _repository;

  PaymentChoiceBloc({required Repository repository})
      : _repository = repository,
        super(PaymentChoiceInitial()) {
    on<PaymentChoiceEvent>((event, emit) async {
      if (event is GetPaymentChoices) {
        await _mapGetPaymentChoicesToState(emit);
      }
    });
  }
  FutureOr<void> _mapGetPaymentChoicesToState(
      Emitter<PaymentChoiceState> emit) async {
    try {
      emit(PaymentChoiceLoading());
      List<PaymentChoice> paymentChoices =
          await _repository.getPaymentChoices();
      emit(PaymentChoiceLoaded(paymentChoices: paymentChoices));
    } catch (e) {
      emit(PaymentChoiceError(message: e.toString()));
    }
  }
}
