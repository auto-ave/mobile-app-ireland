import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class ORWithDividerWidget extends StatelessWidget {
  final Color? dividerColor;
  const ORWithDividerWidget({Key? key, this.dividerColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Divider(
          color: dividerColor,
          
        )),
        SizeConfig.kHorizontalMargin8,
        Text('OR'),
        SizeConfig.kHorizontalMargin8,
        Expanded(
            child: Divider(
          color: dividerColor,
        )),
      ],
    );
  }
}
