part of 'order_review_bloc.dart';

abstract class OrderReviewEvent extends Equatable {
  const OrderReviewEvent();
}

class SetStore extends OrderReviewEvent {
  final Store store;
  SetStore({
    required this.store,
  });
  @override
  List<Object> get props => [store];
}

class SetCart extends OrderReviewEvent {
  final CartModel cart;
  SetCart({
    required this.cart,
  });

  @override
  List<Object> get props => [cart];
}

class SetSlot extends OrderReviewEvent {
  final Slot slot;
  SetSlot({
    required this.slot,
  });
  @override
  List<Object> get props => [slot];
}

class SetVehicle extends OrderReviewEvent {
  final VehicleTypeModel vehicle;
  SetVehicle({
    required this.vehicle,
  });

  @override
  List<Object> get props => [vehicle];
}
