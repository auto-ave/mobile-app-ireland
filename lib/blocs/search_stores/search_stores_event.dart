part of 'search_stores_bloc.dart';

abstract class SearchStoresEvent extends Equatable {
  const SearchStoresEvent();
}

class SearchStores extends SearchStoresEvent {
  final String query;
  final bool forLoadMore;
  final int offset;
  SearchStores({
    required this.query,
    required this.forLoadMore,
    required this.offset,
  });
  @override
  List<Object> get props => [query, forLoadMore, offset];
}
