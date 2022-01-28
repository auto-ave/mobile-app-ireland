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
  final Slot? slot;
  final MultiDaySlot? multiDaySlot;
  SetSlot({this.slot, this.multiDaySlot});

  @override
  List<Object> get props => [];
}
