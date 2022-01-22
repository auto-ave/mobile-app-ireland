import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/cart.dart';

part 'global_cart_event.dart';
part 'global_cart_state.dart';

class GlobalCartBloc extends Bloc<GlobalCartEvent, GlobalCartState> {
  GlobalCartBloc() : super(GlobalCartInitial()) {
    on<GlobalCartEvent>((event, emit) {
      // TODO: implement event handler

      if (event is NewCart) {
        _mapSetCartToState(cart: event.cart, emit: emit);
      }
    });
  }

  void _mapSetCartToState({required CartModel cart, required Emitter emit}) {
    emit(CartSetSuccess(cart: cart));
  }
}
