import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/slot_select/slot_select_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils.dart';

class CartBottomSheet extends StatefulWidget {
  CartBottomSheet({Key? key}) : super(key: key);

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  late CartFunctionBloc _cartFunctionBloc;
  late CartModel cart;
  late OrderReviewBloc _orderReviewBloc;

  @override
  void initState() {
    super.initState();
    _orderReviewBloc = BlocProvider.of<OrderReviewBloc>(context, listen: false);
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocConsumer<CartFunctionBloc, CartFunctionState>(
        bloc: _cartFunctionBloc,
        listener: (_, state) {
          if (state is CartItemAdded ||
              state is CartItemDeleted ||
              state is CartLoaded) {
            if (state is CartItemAdded) {
              if (state.cart.items!.isEmpty) {
                Navigator.pop(context);
              }
            }
            if (state is CartItemDeleted) {
              if (state.cart.items!.isEmpty) {
                Navigator.pop(context);
              }
            }
            if (state is CartLoaded) {
              if (state.cart.items!.isEmpty) {
                Navigator.pop(context);
              }
            }
          }
        },
        builder: (context, state) {
          if (state is CartItemAdded ||
              state is CartItemDeleted ||
              state is CartLoaded ||
              state is CartFunctionLoading) {
            if (state is CartItemAdded) {
              cart = state.cart;
            }
            if (state is CartItemDeleted) {
              cart = state.cart;
            }
            if (state is CartLoaded) {
              cart = state.cart;
            }
            return cart.items!.isEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * .3,
                    child: Center(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Empty Cart',
                          style: SizeConfig.kStyle16W500,
                        ),
                        SizeConfig.kHorizontalMargin8,
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.black,
                        )
                      ],
                    )),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: SizeConfig.kPrimaryColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(cart.store!.name!,
                                style: SizeConfig.kStyle16W500)
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 1,
                      ),
                      ...(cart.itemsObj!.map((e) {
                        return CartItemTile(
                            isLoading: state is CartFunctionLoading &&
                                state.itemId.contains(e.id),
                            cartFunctionBloc: _cartFunctionBloc,
                            itemId: e.id,
                            price: e.price!.toString(),
                            service: e.service!,
                            timeInterval: e.timeInterval!.toString());
                      }).toList()),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Offers',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.moneyBillAlt,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text('Select a promo code'),
                                Spacer(),
                                Text('View offers',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: SizeConfig.kfontSize12))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        decoration:
                            BoxDecoration(color: Colors.white, boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Color.fromRGBO(0, 0, 0, .08),
                              offset: Offset(0, -2))
                        ]),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('₹${cart.total}',
                                    style: TextStyle(
                                        fontSize: SizeConfig.kfontSize16,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'T O T A L',
                                  style: SizeConfig.kStyle12
                                      .copyWith(color: Colors.grey[700]),
                                ),
                              ],
                            ),
                            Spacer(),
                            CommonTextButton(
                                onPressed: () {
                                  _orderReviewBloc.add(SetCart(cart: cart));
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, SlotSelectScreen.route,
                                      arguments: SlotSelectScreenArguments(
                                          cartTotal: cart.total!,
                                          cardId: cart.id!.toString()));
                                },
                                child: Text('Select Slot',
                                    style: TextStyle(color: Colors.white)),
                                backgroundColor: SizeConfig.kPrimaryColor)
                            // TextButton(
                            //   child: Text('Select Slot',
                            //       style: TextStyle(color: Colors.white)),
                            //   onPressed: () {
                            //     _orderReviewBloc.add(SetCart(cart: cart));
                            //     Navigator.pushNamed(
                            //         context, SlotSelectScreen.route,
                            //         arguments: SlotSelectScreenArguments(
                            //             cartTotal: cart.total!,
                            //             cardId: cart.id!.toString()));
                            //   },
                            //   style: ButtonStyle(
                            //       backgroundColor: MaterialStateProperty.all(
                            //           Theme.of(context).primaryColor)),
                            // ),
                          ],
                        ),
                      )
                    ],
                  );
          }

          return Container(
            child: Center(
              child: loadingAnimation(),
            ),
            height: 300,
          );
        },
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final String? service;
  final String? timeInterval;
  final String? price;
  final int? itemId;
  final bool isLoading;
  final CartFunctionBloc cartFunctionBloc;
  const CartItemTile({
    Key? key,
    this.service,
    this.timeInterval,
    this.price,
    this.itemId,
    required this.isLoading,
    required this.cartFunctionBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service!,
                      style: SizeConfig.kStyle16,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('$timeInterval min')
                      ],
                    )
                  ],
                ),
              ),
              Text(
                '₹ $price',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: SizeConfig.kfontSize16),
              ),
              SizedBox(
                width: 16,
              ),
              SizedBox(
                width: 80,
                height: 40,
                child: CommonTextButton(
                  backgroundColor: Colors.white,
                  border: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color(0xffDC1313),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  onPressed: () {
                    cartFunctionBloc.add(DeleteItemFromCart(itemId: itemId!));
                  },
                  child: isLoading
                      ? SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.red,
                          ),
                        )
                      : FittedBox(
                          child: Text(
                            'Remove',
                            style: TextStyle(color: Color(0xffDC1313)),
                          ),
                        ),
                ),
              )
            ])),
        SizeConfig.kverticalMargin8,
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
