import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themotorwash/theme_constants.dart';

class NoServiceWidget extends StatelessWidget {
  const NoServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset('assets/images/thumbs_down.png'),
      kverticalMargin16,
      Text(
        'Sorry we don’t have services your vehicle',
        style: kStyle16.copyWith(color: kGreyTextColor),
      )
    ]);
  }
}
