part of 'cart_function_bloc.dart';

abstract class CartFunctionEvent extends Equatable {
  const CartFunctionEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartFunctionEvent {
  final int itemId;
  AddItemToCart({
    required this.itemId,
  });
}

class DeleteItemFromCart extends CartFunctionEvent {
  final int itemId;
  DeleteItemFromCart({
    required this.itemId,
  });
}

class ClearCart extends CartFunctionEvent {}

class GetCart extends CartFunctionEvent {}
