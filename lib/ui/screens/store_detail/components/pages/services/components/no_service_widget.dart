import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themotorwash/theme_constants.dart';

class NoServiceWidget extends StatelessWidget {
  const NoServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset('assets/images/no_services.png'),
      SizeConfig.kverticalMargin16,
      Text(
        'Sorry we don’t have services your vehicle',
        style: SizeConfig.kStyle16.copyWith(color: SizeConfig.kGreyTextColor),
      )
    ]);
  }
}
