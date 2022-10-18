import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/components/cart_bottom_sheet.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils/utils.dart';

class BottomCartTile extends StatelessWidget {
  final CartModel cart;
  const BottomCartTile({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          _showCartSheet(storeName: 'Store Name', context: context);
          HapticFeedback.lightImpact();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              thickness: 2,
            ),
            Container(
              color: kPrimaryColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${cart.items!.length} items',
                            style: SizeConfig.kStyle16
                                .copyWith(color: Colors.white)),
                        SizedBox(
                          height: 4,
                        ),
                        Text('${cart.total}'.euro(),
                            style: SizeConfig.kStyle20W500
                                .copyWith(color: Colors.white)),
                      ],
                    ),
                    Spacer(),
                    CommonTextButton(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      onPressed: () => _showCartSheet(
                          storeName: 'Store Name', context: context),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Proceed',
                              style: SizeConfig.kStyle16W500
                                  .copyWith(color: SizeConfig.kPrimaryColor)),
                        ],
                      ),
                      backgroundColor: Colors.white,
                      buttonSemantics: 'Proceed',
                    )
                    // TextButton(
                    //   child: Text('View Cart', style: TextStyle(color: Colors.white)),
                    //   onPressed: () =>
                    //       _showCartSheet(storeName: 'Store Name', context: context),
                    //   style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all(
                    //           Theme.of(context).primaryColor)),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _showCartSheet({required String storeName, required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(maxHeight: 80.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (_) {
          return CartBottomSheet();
        });
  }
}
