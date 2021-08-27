part of 'search_stores_bloc.dart';

abstract class SearchStoresState extends Equatable {
  const SearchStoresState();
}

class SearchStoresInitial extends SearchStoresState {
  @override
  List<Object> get props => [];
}

class SearchedStoresResult extends SearchStoresState {
  final List<StoreListModel> searchedStores;
  final bool hasReachedMax;
  SearchedStoresResult(
      {required this.searchedStores, required this.hasReachedMax});

  @override
  List<Object> get props => [searchedStores, hasReachedMax];
}

class LoadingSearchStoresResult extends SearchStoresState {
  @override
  List<Object> get props => [];
}

class LoadingMoreSearchStoresResult extends SearchStoresState {
  @override
  List<Object> get props => [];
}

class SearchedStoresError extends SearchStoresState {
  final String message;
  SearchedStoresError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
