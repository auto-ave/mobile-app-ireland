import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'slot_select_event.dart';
part 'slot_select_state.dart';

class SlotSelectBloc extends Bloc<SlotSelectEvent, SlotSelectState> {
  SlotSelectBloc() : super(SlotSelectInitial());

  @override
  Stream<SlotSelectState> mapEventToState(
    SlotSelectEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
