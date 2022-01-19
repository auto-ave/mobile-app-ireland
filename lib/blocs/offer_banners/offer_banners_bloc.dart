import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/offer.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'offer_banners_event.dart';
part 'offer_banners_state.dart';

class OfferBannersBloc extends Bloc<OfferBannersEvent, OfferBannersState> {
  final Repository _repository;
  OfferBannersBloc({required Repository repository})
      : _repository = repository,
        super(OfferBannersInitial()) {
    on<OfferBannersEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is GetOffersBanners) {
        await _mapGetOffersBannersToState(emit: emit);
      }
    });
  }

  FutureOr<void> _mapGetOffersBannersToState(
      {required Emitter<OfferBannersState> emit}) async {
    try {
      emit(OfferBannersLoading());
      List<OfferModel> offers = await _repository.getOfferBanners();
      emit(OfferBannersLoaded(offers: offers));
    } catch (e) {
      emit(OfferBannersError(message: e.toString()));
    }
  }
}
