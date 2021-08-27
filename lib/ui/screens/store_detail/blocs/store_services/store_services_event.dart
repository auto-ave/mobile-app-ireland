part of 'store_services_bloc.dart';

abstract class StoreServicesEvent extends Equatable {
  const StoreServicesEvent();
}

class LoadStoreServices extends StoreServicesEvent {
  final String slug;
  final String vehicleType;
  final int offset;
  final bool forLoadMore;

  LoadStoreServices(
      {required this.slug,
      required this.vehicleType,
      required this.offset,
      required this.forLoadMore});
  @override
  List<Object?> get props => [slug, vehicleType, offset, forLoadMore];
}
