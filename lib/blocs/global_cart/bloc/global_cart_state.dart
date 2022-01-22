part of 'global_cart_bloc.dart';

abstract class GlobalCartState extends Equatable {
  const GlobalCartState();
}

class GlobalCartInitial extends GlobalCartState {
  @override
  List<Object> get props => [];
}

class CartSetSuccess extends GlobalCartState {
  final CartModel cart;
  CartSetSuccess({
    required this.cart,
  });
  @override
  List<Object> get props => [cart];
}

class CartSetError extends GlobalCartState {
  @override
  List<Object> get props => [];
}
