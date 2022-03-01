import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'featured_stores_event.dart';
part 'featured_stores_state.dart';

class FeaturedStoresBloc
    extends Bloc<FeaturedStoresEvent, FeaturedStoresState> {
  final Repository _repository;
  GlobalLocationBloc _globalLocationBloc;

  FeaturedStoresBloc(
      {required Repository repository,
      required GlobalLocationBloc globalLocationBloc})
      : _repository = repository,
        _globalLocationBloc = globalLocationBloc,
        super(FeaturedStoresInitial()) {
    on<FeaturedStoresEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoadFeaturedStores) {
        await _mapLoadFeaturedStoresToState(emit);
      }
    });
  }

  FutureOr<void> _mapLoadFeaturedStoresToState(
    Emitter emit,
  ) async {
    try {
      var locationState = _globalLocationBloc.state as LocationSet;
      emit(FeaturedStoresLoading());
      emit(FeaturedStoresLoaded(
          stores: await _repository.getFeaturedStores(
              locationModel: locationState.location)));
    } catch (e) {}
  }
}
