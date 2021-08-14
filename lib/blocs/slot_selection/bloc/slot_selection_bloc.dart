import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'slot_selection_event.dart';
part 'slot_selection_state.dart';

class SlotSelectionBloc extends Bloc<SlotSelectionEvent, SlotSelectionState> {
  final Repository _repository;
  SlotSelectionBloc({required Repository repository})
      : _repository = repository,
        super(SlotSelectionInitial());

  @override
  Stream<SlotSelectionState> mapEventToState(
    SlotSelectionEvent event,
  ) async* {
    if (event is GetSlots) {
      yield* _mapGetSlotsToState(date: event.date, cartId: event.cartId);
    }
  }

  Stream<SlotSelectionState> _mapGetSlotsToState(
      {required String date, required String cartId}) async* {
    try {
      yield LoadingSlots();
      List<Slot> slots =
          await _repository.createSlots(date: date, cartId: cartId);
      yield SlotsLoaded(slots: slots);
    } catch (e) {
      yield SlotSelectionError(message: e.toString());
    }
  }
}
