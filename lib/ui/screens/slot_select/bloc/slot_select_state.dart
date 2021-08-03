part of 'slot_select_bloc.dart';

abstract class SlotSelectState extends Equatable {
  const SlotSelectState();

  @override
  List<Object> get props => [];
}

class SlotSelectInitial extends SlotSelectState {}

class SlotsLoaded extends SlotSelectState {}
