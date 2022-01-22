part of 'global_cart_bloc.dart';

abstract class GlobalCartEvent extends Equatable {
  const GlobalCartEvent();
}

class NewCart extends GlobalCartEvent {
  final CartModel cart;
  NewCart({
    required this.cart,
  });
  @override
  List<Object> get props => [cart];
}
