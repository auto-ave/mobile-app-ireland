part of 'order_review_bloc.dart';

abstract class OrderReviewEvent extends Equatable {
  const OrderReviewEvent();
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
