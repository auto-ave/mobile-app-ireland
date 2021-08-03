part of 'store_detail_bloc.dart';

@immutable
abstract class StoreDetailState extends Equatable {
  const StoreDetailState();
}

class StoreDetailInitial extends StoreDetailState {
  @override
  List<Object?> get props => [];
}

class StoreDetailLoaded extends StoreDetailState {
  final Store store;
  StoreDetailLoaded({required this.store});

  @override
  List<Object?> get props => [];
}

class StoreDetailLoading extends StoreDetailState {
  @override
  List<Object?> get props => [];
}

class StoreDetailError extends StoreDetailState {
  final String message;
  StoreDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
