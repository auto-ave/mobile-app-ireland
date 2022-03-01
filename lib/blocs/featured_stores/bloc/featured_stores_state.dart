part of 'featured_stores_bloc.dart';

abstract class FeaturedStoresState extends Equatable {
  const FeaturedStoresState();

  @override
  List<Object> get props => [];
}

class FeaturedStoresInitial extends FeaturedStoresState {}

class FeaturedStoresLoading extends FeaturedStoresState {}

class FeaturedStoresLoaded extends FeaturedStoresState {
  final List<StoreListModel> stores;
  FeaturedStoresLoaded({required this.stores});

  @override
  List<Object> get props => [stores];
}

class FeaturedStoresError extends FeaturedStoresState {
  final String message;
  FeaturedStoresError({required this.message});

  @override
  List<Object> get props => [message];
}
