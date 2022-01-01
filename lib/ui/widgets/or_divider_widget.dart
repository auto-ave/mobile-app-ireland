import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class ORWithDividerWidget extends StatelessWidget {
  const ORWithDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        SizeConfig.kHorizontalMargin8,
        Text('OR'),
        SizeConfig.kHorizontalMargin8,
        Expanded(child: Divider()),
      ],
    );
  }
}
