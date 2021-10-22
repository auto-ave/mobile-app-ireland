import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class Motto extends StatelessWidget {
  const Motto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Caring for your vehicle is our business.",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 40,
          color: SizeConfig.kPrimaryColor),
    );
  }
}
