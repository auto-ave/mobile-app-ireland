import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/authentication_bottom_sheet.dart';
import 'package:themotorwash/ui/widgets/badge.dart';
import 'package:themotorwash/utils.dart';

class StoreServiceTile extends StatelessWidget {
  final String description;
  final String service;
  final String price;
  final int itemId;
  final bool isLoading;
  final bool isAddedToCart;
  final CartFunctionBloc bloc;
  final String time;
  final String vehicleModel;

  final GlobalKey<ScaffoldState> scaffoldState;
  final GlobalAuthBloc globalAuthBloc;

  const StoreServiceTile(
      {Key? key,
      required this.description,
      required this.service,
      required this.price,
      required this.isLoading,
      required this.isAddedToCart,
      required this.bloc,
      required this.itemId,
      required this.scaffoldState,
      required this.time,
      required this.globalAuthBloc,
      required this.vehicleModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(isLoading.toString() + "loading");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * .8,
        // height: MediaQuery.of(context).size.height * .27,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 8,
                  offset: Offset(0, 0))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  service,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: SizeConfig.kPrimaryColor),
                ),
                Spacer(),
                BadgeWidget(text: '$time mins'),
              ],
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
                  decoration: TextDecoration.underline,
                  color: SizeConfig.kPrimaryColor),
            ),
            Row(
              children: <Widget>[
                Text("₹ $price"),
                Spacer(),
                BlocBuilder<GlobalAuthBloc, GlobalAuthState>(
                  bloc: globalAuthBloc,
                  builder: (context, state) {
                    return Builder(
                      builder: (ctx) => SizedBox(
                        width: 120,
                        child: OutlinedButton(
                          onPressed: () {
                            if (state is Authenticated) {
                              if (!isAddedToCart) {
                                bloc.add(AddItemToCart(
                                    itemId: itemId,
                                    vehicleModel: vehicleModel));
                              } else {
                                bloc.add(DeleteItemFromCart(itemId: itemId));
                              }
                            } else {
                              showAuthBottomSheet(ctx);
                            }
                          },
                          style: ButtonStyle(
                            side: MaterialStateProperty.all(BorderSide(
                                color: !isAddedToCart
                                    ? SizeConfig.kPrimaryColor
                                    : Colors.red)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: !isAddedToCart
                                        ? SizeConfig.kPrimaryColor
                                        : Colors.red,
                                  ),
                                )
                              : FittedBox(
                                  child: Text(
                                    !isAddedToCart ? "Add to cart" : "Remove",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: !isAddedToCart
                                            ? SizeConfig.kPrimaryColor
                                            : Colors.red),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showAuthBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: AuthenticationBottomSheet(
              ctx: ctx,
              cartBloc: bloc,
              event: !isAddedToCart
                  ? AddItemToCart(itemId: itemId, vehicleModel: vehicleModel)
                  : DeleteItemFromCart(itemId: itemId),
            ),
          );
        });
  }
}
