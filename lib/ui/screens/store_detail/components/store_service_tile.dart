import 'package:flutter/material.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/cart/cart_function_bloc.dart';

class StoreServiceTile extends StatelessWidget {
  final String description;
  final String service;
  final String price;
  final int itemId;
  final bool isLoading;
  final bool isAddedToCart;
  final CartFunctionBloc bloc;

  const StoreServiceTile(
      {Key? key,
      required this.description,
      required this.service,
      required this.price,
      required this.isLoading,
      required this.isAddedToCart,
      required this.bloc,
      required this.itemId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(isLoading.toString() + "loading");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * .8,
        // height: MediaQuery.of(context).size.height * .27,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(17, 17, 17, 0.06),
                  blurRadius: 24,
                  offset: Offset(0, 20))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              service,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: kPrimaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              description,
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "More info",
              style: TextStyle(
                  decoration: TextDecoration.underline, color: kPrimaryColor),
            ),
            Row(
              children: <Widget>[
                Text("₹ $price"),
                Spacer(),
                OutlinedButton(
                  onPressed: () {
                    if (!isAddedToCart) {
                      bloc.add(AddItemToCart(itemId: itemId));
                    } else {
                      bloc.add(DeleteItemFromCart(itemId: itemId));
                    }
                  },
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: kPrimaryColor)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: isLoading
                      ? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )
                      : Text(
                          !isAddedToCart ? "Add to cart" : "Remove",
                          style: TextStyle(color: kPrimaryColor),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
