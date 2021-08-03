part of 'store_detail_bloc.dart';

@immutable
abstract class StoreDetailEvent extends Equatable {
  const StoreDetailEvent();
}

class LoadStoreDetail extends StoreDetailEvent {
  final String storeSlug;
  const LoadStoreDetail({required this.storeSlug});
  @override
  List<Object?> get props => [];
}
