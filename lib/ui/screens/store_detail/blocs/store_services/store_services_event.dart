part of 'store_services_bloc.dart';

abstract class StoreServicesEvent extends Equatable {
  const StoreServicesEvent();
}

class LoadStoreServices extends StoreServicesEvent {
  final String slug;
  final int vehicleType;
  final int offset;

  LoadStoreServices(
      {required this.slug, required this.vehicleType, required this.offset});
  @override
  List<Object?> get props => [];
}
