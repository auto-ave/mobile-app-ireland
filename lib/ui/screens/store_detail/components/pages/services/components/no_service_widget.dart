import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themotorwash/theme_constants.dart';

class NoServiceWidget extends StatelessWidget {
  const NoServiceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SvgPicture.asset('assets/images/no_services.svg'),
          SizeConfig.kverticalMargin16,
          Text(
            'Sorry we don’t have services your vehicle',
            textAlign: TextAlign.center,
            style:
                SizeConfig.kStyle16.copyWith(color: SizeConfig.kGreyTextColor),
          )
        ]),
      ),
    );
  }
}
