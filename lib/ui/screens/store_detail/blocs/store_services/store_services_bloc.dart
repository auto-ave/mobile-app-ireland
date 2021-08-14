import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'store_services_event.dart';
part 'store_services_state.dart';

class StoreServicesBloc extends Bloc<StoreServicesEvent, StoreServicesState> {
  final Repository _repository;
  StoreServicesBloc({required Repository repository})
      : _repository = repository,
        super(StoreServicesInitial());
  @override
  Stream<StoreServicesState> mapEventToState(
    StoreServicesEvent event,
  ) async* {
    if (event is LoadStoreServices) {
      yield* _mapLoadStoreServicesToState(
          slug: event.slug,
          vehicleType: event.vehicleType,
          offset: event.offset);
    }
  }

  bool _hasReachedMax(StoreServicesState state) =>
      state is StoreServicesLoaded && state.hasReachedMax;

  Stream<StoreServicesState> _mapLoadStoreServicesToState(
      {required String slug,
      required int vehicleType,
      required int offset}) async* {
    if (!_hasReachedMax(state)) {
      try {
        if (state is StoreServicesLoaded) {
          yield StoreServicesLoading();
        }
        List<PriceTimeListModel> services = state is StoreServicesLoaded
            ? (state as StoreServicesLoaded).services
            : [];

        List<PriceTimeListModel> moreServices =
            await _repository.getStoreServicesBySlugAndVehicleType(
                slug: slug, vehicleType: vehicleType, offset: offset);
        yield StoreServicesLoaded(
            services: services + moreServices,
            hasReachedMax: moreServices.isEmpty);
      } catch (e) {
        yield StoreServicesError(message: e.toString());
      }
    }
  }
}
