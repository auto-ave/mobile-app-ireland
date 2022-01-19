part of 'store_list_bloc.dart';

@immutable
abstract class StoreListEvent extends Equatable {}

class LoadNearbyStoreList implements StoreListEvent {
  final int offset;
  final bool forLoadMore;

  LoadNearbyStoreList({required this.offset, required this.forLoadMore});

  @override
  List<Object?> get props => [offset];

  @override
  bool? get stringify => true;
}

class LoadStoreListByService implements StoreListEvent {
  final int offset;
  final String serviceTag;
  final bool forLoadMore;

  LoadStoreListByService(
      {required this.offset,
      required this.serviceTag,
      required this.forLoadMore});

  @override
  List<Object?> get props => [offset, serviceTag, forLoadMore];

  @override
  bool? get stringify => true;
}
