import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:themotorwash/theme_constants.dart';

class StoreInfo extends StatelessWidget {
  final String address;
  final String? displayOpenClosingTime;
  final String? displayDaysOpen;
  final String serviceStartsAt;
  const StoreInfo(
      {Key? key,
      required this.address,
      // required this.openingTime,
      // required this.closingTime,
      required this.serviceStartsAt,
      required this.displayDaysOpen,
      required this.displayOpenClosingTime})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/location.svg',
                  height: 20,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              address,
              style: SizeConfig.kStyle14,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ))
          ],
        ),
        SizeConfig.kverticalMargin8,
        displayOpenClosingTime != null
            ? Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/time.svg',
                        height: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      displayOpenClosingTime!,
                      style: SizeConfig.kStyle14,
                      maxLines: 3,
                    ),
                  )
                  // Text(
                  //     "${openingTime.format(context)} to ${closingTime.format(context)}"),
                ],
              )
            : SizedBox.shrink(),
        SizeConfig.kverticalMargin8,
        displayDaysOpen != null
            ? Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/calendar.svg',
                        height: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      displayDaysOpen!,
                      style: SizeConfig.kStyle14,
                      maxLines: 3,
                    ),
                  )
                ],
              )
            : SizedBox.shrink(),
        SizeConfig.kverticalMargin8,
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: "services start @ ",
              style: TextStyle(
                color: Color(0xff8D8D8D),
              ),
            ),
            TextSpan(
              text: '₹$serviceStartsAt ',
              style: TextStyle(
                  color: SizeConfig.kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          ]),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
