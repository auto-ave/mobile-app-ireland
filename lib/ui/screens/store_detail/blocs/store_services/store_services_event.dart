part of 'store_services_bloc.dart';

abstract class StoreServicesEvent extends Equatable {
  const StoreServicesEvent();
}

class LoadStoreServices extends StoreServicesEvent {
  final String slug;
  final String vehicleType;
  final int offset;
  final bool forLoadMore;
  final String? firstServiceTag;

  LoadStoreServices(
      {required this.slug,
      required this.vehicleType,
      required this.offset,
      required this.forLoadMore,
      required this.firstServiceTag});
  @override
  List<Object?> get props => [slug, vehicleType, offset, forLoadMore];
}
