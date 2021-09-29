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
        SvgPicture.asset('assets/images/error_illustration.svg'),
        kverticalMargin16,
        Text(
          'Oops! an error occured.',
          style: kStyle16PrimaryColor.copyWith(fontWeight: FontWeight.bold),
        ),
        kverticalMargin16,
        ctaType != null
            ? CommonTextButton(
                onPressed: onCTAPressed ??
                    () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ExploreScreen.route, (route) => false);
                    },
                child: Text(
                  ctaType == ErrorCTA.reload ? 'Reload' : 'Home',
                  style: kStyle16SemiBold,
                ),
                backgroundColor: kPrimaryColor)
            : Container()
      ],
    );
  }
}

enum ErrorCTA { home, reload }
