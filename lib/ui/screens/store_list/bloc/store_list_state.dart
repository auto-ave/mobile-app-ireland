part of 'store_list_bloc.dart';

@immutable
abstract class StoreListState extends Equatable {}

class StoreListUninitialized extends StoreListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StoreListLoaded extends StoreListState {
  final List<StoreListModel> stores;
  final bool hasReachedMax;
  StoreListLoaded({
    required this.hasReachedMax,
    required this.stores,
  });

  @override
  List<Object?> get props => [stores];
}

class StoreListError extends StoreListState {
  final String message;
  StoreListError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class StoreListLoading extends StoreListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
