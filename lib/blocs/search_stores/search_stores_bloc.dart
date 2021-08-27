import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/location_model.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'search_stores_event.dart';
part 'search_stores_state.dart';

class SearchStoresBloc extends Bloc<SearchStoresEvent, SearchStoresState> {
  final Repository _repository;
  SearchStoresBloc({required Repository repository})
      : _repository = repository,
        super(SearchStoresInitial());

  @override
  Stream<Transition<SearchStoresEvent, SearchStoresState>> transformEvents(
      Stream<SearchStoresEvent> events,
      TransitionFunction<SearchStoresEvent, SearchStoresState> transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchStoresState> mapEventToState(
    SearchStoresEvent event,
  ) async* {
    if (event is SearchStores) {
      yield* _mapSearchStoresToState(
          query: event.query,
          offset: event.offset,
          forLoadMore: event.forLoadMore);
    }
  }

  bool hasReachedMax(SearchStoresState state) =>
      state is SearchedStoresResult && state.hasReachedMax;
  Stream<SearchStoresState> _mapSearchStoresToState(
      {required String query,
      required int offset,
      required bool forLoadMore}) async* {
    // var locationState = _globalLocationBloc.state as LocationSet;

    if (!hasReachedMax(state)) {
      try {
        List<StoreListModel> stores = [];
        if (state is SearchedStoresResult && forLoadMore) {
          yield LoadingMoreSearchStoresResult();
          stores = (state as SearchedStoresResult).searchedStores;
        } else {
          yield LoadingSearchStoresResult();
        }

        List<StoreListModel> moreStores = await _repository.searchStores(
          query: query,
          offset: offset,
          locationModel:
              LocationModel(city: '462001', lat: 7.123, long: 23.123),
        );
        yield SearchedStoresResult(
            searchedStores: stores + moreStores,
            hasReachedMax: moreStores.length != 10); //Page Limit is 10
      } catch (e) {
        yield SearchedStoresError(message: e.toString());
      }
    }
  }
}
