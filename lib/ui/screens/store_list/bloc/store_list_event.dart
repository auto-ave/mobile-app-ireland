part of 'store_list_bloc.dart';

@immutable
abstract class StoreListEvent extends Equatable {}

class LoadStoreListByCityPressed implements StoreListEvent {
  final String city;
  final int offset;

  LoadStoreListByCityPressed({required this.offset, required this.city});

  @override
  List<Object?> get props => [city];

  @override
  bool? get stringify => true;
}
