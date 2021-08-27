part of 'search_services_bloc.dart';

abstract class SearchServicesEvent extends Equatable {
  const SearchServicesEvent();
}

class SearchServices extends SearchServicesEvent {
  final String query;
  final bool forLoadMore;
  final int offset;
  SearchServices(
      {required this.query, required this.forLoadMore, required this.offset});
  @override
  List<Object> get props => [query, forLoadMore, offset];
}

class YieldUninitializedState extends SearchServicesEvent {
  @override
  List<Object> get props => [];
}
