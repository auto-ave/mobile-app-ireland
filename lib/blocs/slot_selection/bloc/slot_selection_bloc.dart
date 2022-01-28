import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/api/api_service.dart';
import 'package:themotorwash/data/models/multi_day_slot_detail.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:rxdart/rxdart.dart';

part 'slot_selection_event.dart';
part 'slot_selection_state.dart';

class SlotSelectionBloc extends Bloc<SlotSelectionEvent, SlotSelectionState> {
  final Repository _repository;
  SlotSelectionBloc({required Repository repository})
      : _repository = repository,
        super(SlotSelectionInitial()) {
    on<SlotSelectionEvent>(_onEvent, transformer: switchMapTransformer());
  }

  // @override
  // Stream<SlotSelectionState> mapEventToState(
  //   SlotSelectionEvent event,
  // ) async* {
  //   if (event is GetSlots) {
  //     yield* _mapGetSlotsToState(
  //       date: event.date,
  //       cartId: event.cartId,
  //     );
  //   }
  // }

  FutureOr<void> _mapGetSlotsToState({
    required String date,
    required String cartId,
    required Emitter<SlotSelectionState> emit,
  }) async {
    // try {
    //   ApiMethods _apiMethodsImp =
    //       GetIt.I.get<ApiMethods>(instanceName: ApiService.getItInstanceName);

    //   if (!_apiMethodsImp.getSlotsCancelToken.isCancelled) {
    //     print('if called');
    //     _apiMethodsImp.getSlotsCancelToken
    //         .cancel('Canceling all the get slots api calls');
    //   } else {
    //     print('else called');
    //     _apiMethodsImp.getSlotsCancelToken = CancelToken();
    //   }
    // } catch (e) {
    //   print(e.toString() + " Slot API Cancellation Error");
    // }
    try {
      print('Loading FOR' + date.toString());

      // yield LoadingSlots();
      emit(LoadingSlots());
      List<Slot> slots =
          await _repository.createSlots(date: date, cartId: cartId);
      print('SLOTS LOADED FOR' + date.toString());
      // yield SlotsLoaded(slots: slots);
      emit(SlotsLoaded(slots: slots));
    } catch (e) {
      // yield SlotSelectionError(message: e.toString());
      emit(SlotSelectionError(message: e.toString()));
    }
  }

  FutureOr<void> _mapGetMultiDaySlotDetailToState({
    required String date,
    required String cartId,
    required Emitter<SlotSelectionState> emit,
  }) async {
    try {
      print('Loading FOR' + date.toString());

      // yield LoadingSlots();
      emit(LoadingSlots());
      MultiDaySlotDetailModel bigServiceSlotDetailModel =
          await _repository.getMultiDaySlotDetail(date: date, cartId: cartId);
      print('SLOTS LOADED FOR' + date.toString());
      // yield SlotsLoaded(slots: slots);
      emit(MultiDaySlotDetailLoaded(
          multiDaySlotDetail: bigServiceSlotDetailModel));
    } catch (e) {
      // yield SlotSelectionError(message: e.toString());
      emit(SlotSelectionError(message: e.toString()));
    }
  }

  FutureOr<void> _onEvent(
      SlotSelectionEvent event, Emitter<SlotSelectionState> emit) async {
    if (event is GetSlots) {
      await _mapGetSlotsToState(
          date: event.date, cartId: event.cartId, emit: emit);
    } else if (event is GetMultiDaySlotDetail) {
      await _mapGetMultiDaySlotDetailToState(
          date: event.date, cartId: event.cartId, emit: emit);
    }
  }
}

EventTransformer<SlotSelectionEvent> switchMapTransformer() {
  return (events, mapper) => events.switchMap(mapper);
}
