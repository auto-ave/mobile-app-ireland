import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
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
          offset: event.offset,
          forLoadMore: event.forLoadMore,
          firstServiceTag: event.firstServiceTag);
    }
  }

  bool hasReachedMax(StoreServicesState state, bool forLoadMore) =>
      state is StoreServicesLoaded && state.hasReachedMax && forLoadMore;

  Stream<StoreServicesState> _mapLoadStoreServicesToState(
      {required String slug,
      required String vehicleType,
      required int offset,
      required bool forLoadMore,
      String? firstServiceTag}) async* {
    if (!hasReachedMax(state, forLoadMore)) {
      try {
        List<PriceTimeListModel> services = [];

        if (state is StoreServicesLoaded && forLoadMore) {
          services = (state as StoreServicesLoaded).services;
          yield MoreStoreServicesLoading();
        } else {
          yield StoreServicesLoading();
        }
        List<PriceTimeListModel> moreServices =
            await _repository.getStoreServicesBySlugAndVehicleType(
                slug: slug,
                vehicleType: vehicleType,
                offset: offset,
                firstServiceTag: firstServiceTag);
        yield StoreServicesLoaded(
            vehicleType: vehicleType,
            services: services + moreServices,
            hasReachedMax: moreServices.length !=
                10); // Page Limit set in apiconstants is 10. Therefore if services retured are less than 10, then hasReachedMax is true
      } catch (e) {
        yield StoreServicesError(message: e.toString());
      }
    }
  }
}
