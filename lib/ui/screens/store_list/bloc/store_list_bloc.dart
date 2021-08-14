import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'store_list_event.dart';
part 'store_list_state.dart';

class StoreListBloc extends Bloc<StoreListEvent, StoreListState> {
  Repository _repository;
  StoreListBloc({required Repository repository})
      : _repository = repository,
        super(StoreListUninitialized());

  @override
  Stream<StoreListState> mapEventToState(
    StoreListEvent event,
  ) async* {
    if (event is LoadStoreListByCityPressed) {
      yield* _mapLoadStoreListByCityPressedToState(
          city: event.city, offset: event.offset);
    }
  }

  bool _hasReachedMax(StoreListState state) =>
      state is StoreListLoaded && state.hasReachedMax;

  Stream<StoreListState> _mapLoadStoreListByCityPressedToState(
      {required String city, required int offset}) async* {
    if (!_hasReachedMax(state)) {
      try {
        if (state is StoreListLoaded) {
          yield StoreListLoading();
        }
        List<StoreListModel> stores =
            state is StoreListLoaded ? (state as StoreListLoaded).stores : [];

        List<StoreListModel> moreStores =
            await _repository.getStoreListByCity(city: city, offset: offset);
        yield StoreListLoaded(
            stores: stores + moreStores, hasReachedMax: moreStores.isEmpty);
      } catch (e) {
        yield StoreListError(message: e.toString());
      }
    }
  }
}
