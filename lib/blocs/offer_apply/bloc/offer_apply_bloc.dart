import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/blocs/global_cart/bloc/global_cart_bloc.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'offer_apply_event.dart';
part 'offer_apply_state.dart';

class OfferApplyBloc extends Bloc<OfferApplyEvent, OfferApplyState> {
  final Repository _repository;
  final GlobalCartBloc _globalCartBloc;
  OfferApplyBloc(
      {required Repository repository, required GlobalCartBloc globalCartBloc})
      : _repository = repository,
        _globalCartBloc = globalCartBloc,
        super(OfferApplyInitial()) {
    on<OfferApplyEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is ApplyOffer) {
        await _mapApplyOfferToState(code: event.code, emit: emit);
      } else if (event is RemoveOffer) {
        await _mapRemoveOfferToState(emit);
      }
    });
  }

  FutureOr<void> _mapApplyOfferToState(
      {required String code, required Emitter emit}) async {
    try {
      emit(OfferApplyLoading());
      CartModel cart = await _repository.applyOffer(code);
      _globalCartBloc.add(NewCart(cart: cart));
      emit(OfferApplySuccess(cart: cart, offerSuccessType: OfferSuccess.apply));
    } catch (e) {
      emit(OfferApplyError(
          message: e.toString(), offerErrorType: OfferError.apply));
    }
  }

  FutureOr<void> _mapRemoveOfferToState(Emitter<OfferApplyState> emit) async {
    try {
      emit(OfferApplyLoading());
      CartModel cart = await _repository.removeOffer();
      _globalCartBloc.add(NewCart(cart: cart));
      emit(
          OfferApplySuccess(cart: cart, offerSuccessType: OfferSuccess.remove));
    } catch (e) {
      emit(OfferApplyError(
          message: e.toString(), offerErrorType: OfferError.remove));
    }
  }
}
