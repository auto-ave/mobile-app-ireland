import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'store_detail_event.dart';
part 'store_detail_state.dart';

class StoreDetailBloc extends Bloc<StoreDetailEvent, StoreDetailState> {
  final Repository _repository;
  StoreDetailBloc({required Repository repository})
      : _repository = repository,
        super(StoreDetailInitial());

  @override
  Stream<StoreDetailState> mapEventToState(
    StoreDetailEvent event,
  ) async* {
    if (event is LoadStoreDetail) {
      yield* _mapGetStoreDetailPressedToState(event.storeSlug);
    }
  }

  Stream<StoreDetailState> _mapGetStoreDetailPressedToState(
      String storeSlug) async* {
    try {
      yield StoreDetailLoading();
      Store store = await _repository.getStoreDetailBySlug(slug: storeSlug);
      yield StoreDetailLoaded(store: store);
    } catch (e) {
      yield StoreDetailError(message: e.toString());
    }
  }
}
