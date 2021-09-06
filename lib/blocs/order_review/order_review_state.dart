part of 'order_review_bloc.dart';

abstract class OrderReviewState extends Equatable {
  const OrderReviewState();
}

class OrderReviewInitial extends OrderReviewState {
  @override
  List<Object> get props => [];
}

class LocalOrderRetrieved extends OrderReviewState {
  final Slot slot;
  final CartModel cart;

  LocalOrderRetrieved({
    required this.slot,
    required this.cart,
  });

  @override
  List<Object> get props => [
        cart,
        slot,
      ];
}
