import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';

class ErrorScreen extends StatelessWidget {
  final bool isHome;
  final Function()? onPressed;
  final bool showCTA;
  const ErrorScreen({
    Key? key,
    required this.isHome,
    this.onPressed,
    this.showCTA = true,
  }) : super(key: key);

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
        showCTA
            ? CommonTextButton(
                onPressed: onPressed ??
                    () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, ExploreScreen.route, (route) => false);
                    },
                child: Text(
                  isHome ? 'Reload' : 'Home',
                  style: kStyle16SemiBold,
                ),
                backgroundColor: kPrimaryColor)
            : Container()
      ],
    );
  }
}
