import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'offer_apply_event.dart';
part 'offer_apply_state.dart';

class OfferApplyBloc extends Bloc<OfferApplyEvent, OfferApplyState> {
  final Repository _repository;
  OfferApplyBloc({required Repository repository})
      : _repository = repository,
        super(OfferApplyInitial()) {
    on<OfferApplyEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is ApplyOffer) {
        await _mapApplyOfferToState(code: event.code, emit: emit);
      }
    });
  }

  FutureOr<void> _mapApplyOfferToState(
      {required String code, required Emitter emit}) async {
    try {
      emit(OfferApplyLoading());
      CartModel cart = await _repository.applyOffer(code);
      emit(OfferApplySuccess(cart: cart));
    } catch (e) {
      emit(OfferApplyError(message: e.toString()));
    }
  }
}
