import 'dart:ui';

import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xff3570B5);
const double kfontSize18 = 18;
const double kfontSize16 = 16;
const double kfontSize12 = 12;
const double kfontSize10 = 10;
const double kfontSize20 = 20;
const double kfontSize14 = 14;
const double kfontSize24 = 24;

const SizedBox kverticalMargin8 = const SizedBox(
  height: 8,
);
const SizedBox kverticalMargin4 = const SizedBox(
  height: 4,
);

const SizedBox kverticalMargin16 = const SizedBox(
  height: 16,
);

const SizedBox kverticalMargin32 = const SizedBox(
  height: 32,
);
const SizedBox kHorizontalMargin4 = const SizedBox(
  width: 4,
);
const SizedBox kHorizontalMargin8 = const SizedBox(
  width: 8,
);
const SizedBox kHorizontalMargin16 = const SizedBox(
  width: 16,
);
const SizedBox kHorizontalMargin32 = const SizedBox(
  width: 32,
);
const TextStyle kStyle12PrimaryColor = const TextStyle(
    color: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: kfontSize12);
const TextStyle kStyle12 =
    const TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize12);
const TextStyle kStyle10 =
    const TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize10);
const TextStyle kStyle14SemiBold =
    const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize14);
const TextStyle kStyle14 = const TextStyle(fontSize: kfontSize14);

const TextStyle kStyle14PrimaryColor =
    const TextStyle(fontSize: kfontSize14, color: kPrimaryColor);
const TextStyle kStyle14W500 =
    const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize14);
const TextStyle kStyle12SemiBold =
    const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize12);

const TextStyle kStyle16SemiBold =
    const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize16);
const TextStyle kStyle16Bold =
    const TextStyle(fontWeight: FontWeight.w700, fontSize: kfontSize16);
const TextStyle kStyle16 = const TextStyle(fontSize: kfontSize16);
const TextStyle kStyle16W500 =
    const TextStyle(fontSize: kfontSize16, fontWeight: FontWeight.w500);
const TextStyle kStyle16PrimaryColor =
    const TextStyle(fontSize: kfontSize16, color: kPrimaryColor);

const TextStyle kStyle24Bold =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: kfontSize24);
const TextStyle kStyle20Bold =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: kfontSize20);
const TextStyle kStyle20W500 =
    const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize20);

TextStyle selectedTabTextStyle =
    kStyle16Bold.copyWith(color: kPrimaryColor, fontFamily: 'DM Sans');
TextStyle unSelectedTabTextStyle = kStyle16.copyWith(fontFamily: 'DM Sans');

Color? kShimmerBaseColor = Colors.grey[100];

Color? kShimmerHighlightColor = Colors.grey[200];

Color kGreyTextColor = Color(0xff696969);
