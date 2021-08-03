import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/cart/cart_function_bloc.dart';
import 'package:themotorwash/ui/screens/slot_select/slot_select_screen.dart';

class CartBottomSheet extends StatefulWidget {
  final String storeName;

  CartBottomSheet({Key? key, required this.storeName}) : super(key: key);

  @override
  _CartBottomSheetState createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  late CartFunctionBloc _cartFunctionBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<CartFunctionBloc, CartFunctionState>(
        bloc: _cartFunctionBloc,
        builder: (context, state) {
          if (state is CartItemAdded ||
              state is CartItemDeleted ||
              state is CartLoaded) {
            late CartModel cart;
            if (state is CartItemAdded) {
              cart = state.cart;
            }
            if (state is CartItemDeleted) {
              cart = state.cart;
            }
            if (state is CartLoaded) {
              cart = state.cart;
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined),
                      SizedBox(
                        width: 8,
                      ),
                      Text(widget.storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: kfontSize18))
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                ),
                ...(cart.itemsObj!.map((e) {
                  return CartItemTile(
                      price: e.price!.toString(),
                      service: e.service!,
                      timeInterval: e.timeInterval!.toString());
                }).toList()),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                  fontSize: kfontSize12))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    Padding(
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
                                      fontSize: kfontSize16,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'T O T A L',
                                style: TextStyle(
                                    fontSize: kfontSize12,
                                    color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          Spacer(),
                          TextButton(
                            child: Text('Select Slot',
                                style: TextStyle(color: Colors.white)),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SlotSelectScreen.route);
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  const CartItemTile(
      {Key? key,
      required this.service,
      required this.timeInterval,
      required this.price})
      : super(key: key);

  final String service;
  final String timeInterval;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service,
                      style: TextStyle(fontSize: kfontSize16),
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
                    fontSize: kfontSize18),
              ),
              SizedBox(
                width: 16,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Remove',
                  style: TextStyle(color: Color(0xffDC1313)),
                ),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: Color(0xffDC1313),
                      width: 1,
                    ),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )
            ]),
            kverticalMargin8,
            Divider(
              height: 1,
              thickness: 1,
            ),
          ],
        ));
  }
}
