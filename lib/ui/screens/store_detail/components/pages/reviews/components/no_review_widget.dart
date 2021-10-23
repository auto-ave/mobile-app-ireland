import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themotorwash/theme_constants.dart';

class NoReviewWidget extends StatelessWidget {
  const NoReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset('assets/images/no_reviews.png'),
      SizeConfig.kverticalMargin16,
      Text(
        'No reviews yet!',
        style: SizeConfig.kStyle16.copyWith(color: SizeConfig.kGreyTextColor),
      )
    ]);
  }
}
