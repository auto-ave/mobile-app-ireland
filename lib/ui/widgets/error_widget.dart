import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';

class ErrorScreen extends StatelessWidget {
  ErrorCTA? ctaType;

  Function()? onCTAPressed;

  ErrorScreen({ErrorCTA? ctaType, Function()? onCTAPressed}) {
    // if cta type is reload then onCtaPressed function must be provide
    // if cta type is home then onCtaPressed is not needed
    assert(!(ctaType == ErrorCTA.reload && onCTAPressed == null));
    this.ctaType = ctaType;
    this.onCTAPressed = onCTAPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/no_results.png'),
        SizeConfig.kverticalMargin16,
        Text(
          'Something went wrong',
          style: SizeConfig.kStyle16.copyWith(color: SizeConfig.kGreyTextColor),
        ),
        SizeConfig.kverticalMargin16,
        ctaType != null
            ? CommonTextButton(
                onPressed: onCTAPressed ??
                    () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ExploreScreen.route, (route) => false);
                    },
                child: Text(
                  ctaType == ErrorCTA.reload ? 'Reload' : 'Home',
                  style: SizeConfig.kStyle16W500.copyWith(color: Colors.white),
                ),
                backgroundColor: SizeConfig.kPrimaryColor)
            : Container()
      ],
    );
  }
}

enum ErrorCTA { home, reload }
