import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:themotorwash/theme_constants.dart';

class StoreInfo extends StatelessWidget {
  final String address;
  // final TimeOfDay openingTime;
  // final TimeOfDay closingTime;
  final String serviceStartsAt;
  const StoreInfo({
    Key? key,
    required this.address,
    // required this.openingTime,
    // required this.closingTime,
    required this.serviceStartsAt,
  }) : super(key: key);
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
              style: kStyle14,
              overflow: TextOverflow.ellipsis,
            ))
          ],
        ),
        kverticalMargin8,
        Row(
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
            Text(
              "9am to 6pm test",
              style: kStyle14,
            )
            // Text(
            //     "${openingTime.format(context)} to ${closingTime.format(context)}"),
          ],
        ),
        kverticalMargin8,
        Row(
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
            Text(
              "Monday - Saturday",
              style: kStyle14,
            )
          ],
        ),
        kverticalMargin8,
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
                  color: kPrimaryColor,
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
