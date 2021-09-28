part of 'fcm_bloc.dart';

abstract class FcmState extends Equatable {
  const FcmState();
  
  @override
  List<Object> get props => [];
}

class FcmInitial extends FcmState {}
