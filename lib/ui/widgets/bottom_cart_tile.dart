import 'package:flutter/material.dart';

import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/components/cart_bottom_sheet.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';

class BottomCartTile extends StatelessWidget {
  final CartModel cart;
  const BottomCartTile({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${cart.items!.length} items',
                      style: TextStyle(
                          fontSize: SizeConfig.kfontSize16,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 4,
                  ),
                  Text('₹${cart.total}',
                      style: TextStyle(
                          fontSize: SizeConfig.kfontSize16,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              Spacer(),
              CommonTextButton(
                  onPressed: () =>
                      _showCartSheet(storeName: 'Store Name', context: context),
                  child:
                      Text('View Cart', style: TextStyle(color: Colors.white)),
                  backgroundColor: Theme.of(context).primaryColor)
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
        )
      ],
    );
  }

  _showCartSheet({required String storeName, required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (_) {
          return CartBottomSheet();
        });
  }
}
