part of 'cart_function_bloc.dart';

abstract class CartFunctionState extends Equatable {
  const CartFunctionState();
}

class CartFunctionUninitialized extends CartFunctionState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CartLoaded extends CartFunctionState {
  final CartModel cart;
  CartLoaded({
    required this.cart,
  });
  List<Object?> get props => [cart];
}

class CartItemAdded extends CartFunctionState {
  final CartModel cart;
  CartItemAdded({
    required this.cart,
  });
  @override
  List<Object?> get props => [cart];
}

class CartItemDeleted extends CartFunctionState {
  final CartModel cart;
  CartItemDeleted({
    required this.cart,
  });

  @override
  List<Object?> get props => [cart];
}

class CartStateError extends CartFunctionState {
  final String message;
  CartStateError({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}

class CartFunctionLoading extends CartFunctionState {
  final List<int> itemId;
  CartFunctionLoading({
    required this.itemId,
  });

  @override
  List<Object?> get props => [...itemId];
  // ...

  @override
  String toString() => 'CartFunctionLoading(itemId: $itemId)';
}

class CartLoading extends CartFunctionState {
  @override
  List<Object?> get props => [];
}
