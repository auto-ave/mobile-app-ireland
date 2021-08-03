part of 'store_services_bloc.dart';

abstract class StoreServicesState extends Equatable {
  const StoreServicesState();
}

class StoreServicesInitial extends StoreServicesState {
  @override
  List<Object?> get props => [];
}

class StoreServicesLoaded extends StoreServicesState {
  final List<PriceTimeListModel> services;
  final bool hasReachedMax;
  StoreServicesLoaded({
    required this.services,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [services];
}

class StoreServicesLoading extends StoreServicesState {
  @override
  List<Object?> get props => [];
}

class StoreServicesError extends StoreServicesState {
  final String message;
  StoreServicesError({required this.message});

  @override
  List<Object?> get props => [message];
}
