import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'cart_function_event.dart';
part 'cart_function_state.dart';

class CartFunctionBloc extends Bloc<CartFunctionEvent, CartFunctionState> {
  final Repository _repository;
  CartFunctionBloc({required Repository repository})
      : _repository = repository,
        super(CartFunctionUninitialized());

  @override
  Stream<CartFunctionState> mapEventToState(
    CartFunctionEvent event,
  ) async* {
    if (event is AddItemToCart) {
      yield* _mapAddItemToCartToState(itemId: event.itemId);
    } else if (event is DeleteItemFromCart) {
      yield* _mapDeleteItemFromCart(itemId: event.itemId);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
    } else if (event is GetCart) {
      yield* _mapGetCartToState();
    }
  }

  Stream<CartFunctionState> _mapAddItemToCartToState(
      {required int itemId}) async* {
    try {
      if (state is CartFunctionLoading) {
        var previousItems = (state as CartFunctionLoading).itemId;
        previousItems.add(itemId);
        print(previousItems.toString() + "helolo" + "add");

        yield CartFunctionLoading(itemId: previousItems);
      } else {
        print("loladdhelolo");

        yield CartFunctionLoading(itemId: [itemId]);
      }

      CartModel cart = await _repository.postAddItemToCart(itemId: itemId);
      yield CartItemAdded(cart: cart);
    } catch (e) {
      yield CartStateError(message: e.toString());
    }
  }

  Stream<CartFunctionState> _mapDeleteItemFromCart(
      {required int itemId}) async* {
    try {
      if (state is CartFunctionLoading) {
        var previousItems = (state as CartFunctionLoading).itemId;
        previousItems.add(itemId);
        // print(previousItems.toString() + "helolo");
        yield CartFunctionLoading(itemId: previousItems);
      } else {
        // print("lolhelolo");
        yield CartFunctionLoading(itemId: [itemId]);
      }
      CartModel cart = await _repository.postDeleteItemFromCart(itemId: itemId);
      yield CartItemDeleted(cart: cart);
    } catch (e) {
      yield CartStateError(message: e.toString());
    }
  }

  Stream<CartFunctionState> _mapClearCartToState() async* {
    // try {
    //   CartModel cart = await _repository.postAddItemToCart(itemId: itemId);
    //   yield CartItemAdded(cart: cart);
    // } catch (e) {
    //   yield CartStateError(message: e.toString());
    // }
  }

  Stream<CartFunctionState> _mapGetCartToState() async* {
    try {
      yield CartLoading();

      CartModel cart = await _repository.getCart();

      yield CartLoaded(cart: cart);
    } catch (e) {
      yield CartStateError(message: e.toString());
    }
  }
}
