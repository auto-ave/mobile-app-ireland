import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/offer.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'offer_list_event.dart';
part 'offer_list_state.dart';

class OfferListBloc extends Bloc<OfferListEvent, OfferListState> {
  final Repository _repository;
  OfferListBloc({required Repository repository})
      : _repository = repository,
        super(OfferListInitial()) {
    on<OfferListEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetOffersList) {
        await _mapGetOffersListToState(emit: emit);
      }
    });
  }

  FutureOr<void> _mapGetOffersListToState(
      {required Emitter<OfferListState> emit}) async {
    try {
      emit(OfferListLoading());
      List<OfferModel> offers = await _repository.getOfferList();
      emit(OfferListLoaded(offers: offers));
    } catch (e) {
      emit(OfferListError(message: e.toString()));
    }
  }
}
