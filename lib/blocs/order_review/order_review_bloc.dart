import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/vehicle_type.dart';

part 'order_review_event.dart';
part 'order_review_state.dart';

class OrderReviewBloc extends Bloc<OrderReviewEvent, OrderReviewState> {
  OrderReviewBloc() : super(OrderReviewInitial());
  Store? store;
  CartModel? cart;
  Slot? slot;
  VehicleTypeModel? vehicle;
  @override
  Stream<OrderReviewState> mapEventToState(
    OrderReviewEvent event,
  ) async* {
    if (event is SetStore) {
      store = event.store;
    } else if (event is SetCart) {
      cart = event.cart;
    } else if (event is SetVehicle) {
      vehicle = event.vehicle;
    } else if (event is SetSlot) {
      slot = event.slot;
      yield LocalOrderRetrieved(
          slot: slot!, cart: cart!, store: store!, vehicle: vehicle!);
    }
  }
}