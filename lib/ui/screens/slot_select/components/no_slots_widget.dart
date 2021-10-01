import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class NoSlotsWidget extends StatelessWidget {
  const NoSlotsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/no_slots.png'),
        kverticalMargin8,
        Text(
          'The store is closed on the selected date',
          style: kStyle16.copyWith(color: kGreyTextColor),
        ),
      ],
    );
  }
}