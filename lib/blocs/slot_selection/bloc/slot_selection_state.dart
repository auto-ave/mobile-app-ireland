part of 'slot_selection_bloc.dart';

abstract class SlotSelectionState extends Equatable {
  const SlotSelectionState();
}

class SlotSelectionInitial extends SlotSelectionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SlotsLoaded extends SlotSelectionState {
  final List<Slot> slots;
  SlotsLoaded({
    required this.slots,
  });

  @override
  List<Object?> get props => [slots];
}

class LoadingSlots extends SlotSelectionState {
  @override
  List<Object?> get props => [];
}

class SlotSelectionError extends SlotSelectionState {
  final String message;
  SlotSelectionError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
