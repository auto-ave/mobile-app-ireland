import 'package:flutter/material.dart';

import 'package:themotorwash/theme_constants.dart';

class BadgeWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  const BadgeWidget({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //       offset: Offset(0, 1),
          //       blurRadius: 4,
          //       color: Color.fromRGBO(0, 0, 0, 0.25))
          // ],
          color: SizeConfig.kBadgeColor,
          borderRadius: BorderRadius.circular(2)),
      child: Center(
        child: Text(
          text,
          style: textStyle ??
              TextStyle(fontSize: 10, color: SizeConfig.kPrimaryColor),
        ),
      ),
    );
  }
}
