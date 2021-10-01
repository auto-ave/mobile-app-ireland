part of 'cart_function_bloc.dart';

abstract class CartFunctionEvent extends Equatable {
  const CartFunctionEvent();
}

class AddItemToCart extends CartFunctionEvent {
  final int itemId;
  final String vehicleModel;
  AddItemToCart({
    required this.itemId,
    required this.vehicleModel,
  });

  @override
  List<Object> get props => [];
}

class DeleteItemFromCart extends CartFunctionEvent {
  final int itemId;
  DeleteItemFromCart({
    required this.itemId,
  });

  @override
  List<Object> get props => [];
}

class ClearCart extends CartFunctionEvent {
  @override
  List<Object> get props => [];
}

class GetCart extends CartFunctionEvent {
  @override
  List<Object> get props => [];
}
