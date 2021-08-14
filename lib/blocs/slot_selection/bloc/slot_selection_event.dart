part of 'slot_selection_bloc.dart';

abstract class SlotSelectionEvent extends Equatable {
  const SlotSelectionEvent();
}

class GetSlots extends SlotSelectionEvent {
  final String date;
  final String cartId;
  GetSlots({required this.date, required this.cartId});

  @override
  List<Object?> get props => [date];
}
