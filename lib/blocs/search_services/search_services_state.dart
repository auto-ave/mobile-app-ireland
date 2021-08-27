part of 'search_services_bloc.dart';

abstract class SearchServicesState extends Equatable {
  const SearchServicesState();
}

class SearchServicesUninitialized extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class SearchedServicesResult extends SearchServicesState {
  final List<ServiceModel> searchedServices;
  final bool hasReachedMax;
  SearchedServicesResult({
    required this.searchedServices,
    required this.hasReachedMax,
  });
  @override
  List<Object> get props => [searchedServices, hasReachedMax];
}

class LoadingSearchServicesResult extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class LoadingMoreSearchServicesResult extends SearchServicesState {
  @override
  List<Object> get props => [];
}

class SearchedServicesError extends SearchServicesState {
  final String message;
  SearchedServicesError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
