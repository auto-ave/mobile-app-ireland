import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/models/service.dart';
import 'package:themotorwash/main.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/authentication_bottom_sheet.dart';
import 'package:themotorwash/ui/widgets/badge.dart';
import 'package:themotorwash/utils/utils.dart';
import 'package:expandable_text/expandable_text.dart';

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
  final PriceTimeOfferDetail? offer;
  final List<ServiceModel>? tags;

  final GlobalKey<ScaffoldState> scaffoldState;
  final GlobalAuthBloc globalAuthBloc;
  final List<BadgeColors> _badgeColors = SizeConfig.badgeColors;
  final Random _rand = Random();
  StoreServiceTile(
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
      required this.vehicleModel,
      required this.offer,
      this.tags})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    // print(isLoading.toString() + "loading");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Container(
        // padding: const EdgeInsets.all(16),
        width: 80.w,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          service,
                          maxLines: 10,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: SizeConfig.kPrimaryColor,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      BadgeWidget(
                        text: '$time',
                        textStyle: SizeConfig.kStyle14Bold
                            .copyWith(color: SizeConfig.kPrimaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ExpandableText(
                    description,
                    expandText: 'show more',
                    collapseText: 'show less',
                    maxLines: 3,
                    linkColor: Colors.blue,

                    linkStyle: SizeConfig.kStyle16Bold,

                    // textAlign: TextAlign.left,
                    // prefixStyle: ,
                  ),

                  // Text(
                  //   "More info",
                  //   style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //       color: SizeConfig.kPrimaryColor),
                  // ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "₹ $price",
                        style: SizeConfig.kStyle16W500.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      BlocBuilder<GlobalAuthBloc, GlobalAuthState>(
                        bloc: globalAuthBloc,
                        builder: (context, state) {
                          return Builder(
                            builder: (ctx) => SizedBox(
                                // width: 150,
                                child: !isAddedToCart
                                    ? AddToCartButton(
                                        isLoading: isLoading,
                                        onPressed: () {
                                          if (state is Authenticated) {
                                            bloc.add(AddItemToCart(
                                                itemId: itemId,
                                                vehicleModel: vehicleModel));
                                          } else {
                                            showAuthBottomSheet(ctx);
                                          }
                                        })
                                    : RemoveFromCartButton(
                                        isLoading: isLoading,
                                        onPressed: () {
                                          if (state is Authenticated) {
                                            bloc.add(DeleteItemFromCart(
                                                itemId: itemId));
                                          } else {
                                            showAuthBottomSheet(ctx);
                                          }
                                        })),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            tags != null
                ? Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 20, right: 8),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags!.map((e) {
                        final badgeColor =
                            BadgeCharColors().getColorForChar(e.name ?? 'a');
                        return BadgeWidget(
                          text: e.name != null ? e.name!.toUpperCase() : '',
                          backgroundColor: badgeColor.backgroundColor,
                          textStyle: SizeConfig.kStyle10.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: badgeColor.textColor),
                        );
                      }).toList(),
                    ),
                  )
                : SizedBox.shrink(),
            // Text(
            //   description,
            //   maxLines: 8,
            //   overflow: TextOverflow.ellipsis,
            // ),
            SizedBox(
              height: 8,
            ),
            offer != null
                ? GestureDetector(
                    onTap: () {
                      showSnackbar(context, 'Code copied');
                      HapticFeedback.heavyImpact();
                      Clipboard.setData(ClipboardData(text: offer!.offerCode!));
                      // mixpanel?.track('Service Tile Offer Click');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: Color(0xffF9FFD6),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: Row(
                        children: [
                          Lottie.asset('assets/animations/gift.json',
                              height: 40, width: 40),
                          SizeConfig.kHorizontalMargin8,
                          Expanded(
                              child: Text(
                            offer!.offerText!,
                            style: SizeConfig.kStyle12
                                .copyWith(color: Color(0xff023C6D)),
                          )),
                          SizeConfig.kHorizontalMargin16,
                          Text.rich(TextSpan(children: [
                            TextSpan(
                                text: 'Use Code:',
                                style: SizeConfig.kStyle12
                                    .copyWith(color: Color(0xff023C6D))),
                            TextSpan(
                                text: ' ${offer!.offerCode}',
                                style: SizeConfig.kStyle12.copyWith(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w700))
                          ])),
                          // Text(
                          //   "Use code: $offerCode",
                          //   style: SizeConfig.kStyle14Bold
                          //       .copyWith(color: Color(0xff023C6D),
                          // ),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink()
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

class AddToCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const AddToCartButton(
      {Key? key, required this.isLoading, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
        HapticFeedback.mediumImpact();
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(
            BorderSide(color: SizeConfig.kPrimaryColor)),
        padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: 0, horizontal: 0)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
      ),
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: SizeConfig.kPrimaryColor,
                ),
              ),
            )
          : Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: SizeConfig.kPrimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 8, top: 8, bottom: 8),
                  child: FittedBox(
                    child: Text(
                      " Add Service",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: SizeConfig.kPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class RemoveFromCartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  const RemoveFromCartButton(
      {Key? key, required this.isLoading, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
        HapticFeedback.mediumImpact();
      },
      style: ButtonStyle(
        side: MaterialStateProperty.all(BorderSide(color: Colors.red)),
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
                strokeWidth: 2,
                color: Colors.red,
              ),
            )
          : FittedBox(
              child: Text(
                "Remove",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.red),
              ),
            ),
    );
  }
}
