import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SizeConfig {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;
  static double? _safeAreaHorizontal;
  static double? _safeAreaVertical;
  static double? safeBlockHorizontal;
  static double? safeBlockVertical;
  static double? textScaleFactor;

  static Color kPrimaryColor = Color(0xff3570B5);
  static Color kReddish = Color(0xffDC1313);
  static late double kfontSize18;
  static late double kfontSize16;
  static late double kfontSize12;
  static late double kfontSize10;
  static late double kfontSize20;
  static late double kfontSize14;
  static late double kfontSize24;

  static const SizedBox kverticalMargin8 = const SizedBox(
    height: 8,
  );
  static const SizedBox kverticalMargin4 = const SizedBox(
    height: 4,
  );

  static const SizedBox kverticalMargin16 = const SizedBox(
    height: 16,
  );

  static const SizedBox kverticalMargin24 = const SizedBox(
    height: 24,
  );

  static const SizedBox kverticalMargin32 = const SizedBox(
    height: 32,
  );
  static const SizedBox kHorizontalMargin4 = const SizedBox(
    width: 4,
  );
  static const SizedBox kHorizontalMargin8 = const SizedBox(
    width: 8,
  );
  static const SizedBox kHorizontalMargin16 = const SizedBox(
    width: 16,
  );
  static const SizedBox kHorizontalMargin32 = const SizedBox(
    width: 32,
  );
  static late TextStyle kStyle12PrimaryColor;
  static late TextStyle kStyle12;

  static late TextStyle kStyle10;
  static late TextStyle kStyle14;
  static late TextStyle kStyle14Bold;

  static late TextStyle kStyle14W500;

  static late TextStyle kStyle14PrimaryColor;

  static late TextStyle kStyle12W500;
  static late TextStyle kStyle16;

  static late TextStyle kStyle16Bold;

  static late TextStyle kStyle16W500;

  static late TextStyle kStyle16PrimaryColor;

  static late TextStyle kStyle24Bold;

  static late TextStyle kStyle20Bold;

  static late TextStyle kStyle20W500;

  static late TextStyle selectedTabTextStyle;
  // kStyle16Bold.copyWith(color: kPrimaryColor, fontFamily: 'DM Sans');
  static late TextStyle unSelectedTabTextStyle;
  // kStyle16.copyWith(fontFamily: 'DM Sans');

  static Color? kShimmerBaseColor = Colors.grey[100];

  static Color? kShimmerHighlightColor = Colors.grey[200];

  static Color kGreyTextColor = Color(0xff696969);

  static Color kBadgeColor = Color.fromRGBO(218, 235, 255, 1);

  static late TextStyle kStyleAppBarTitle;
  void init(BuildContext context) {
    print('init called');
    mediaQueryData = MediaQuery.of(context);
    // textScaleFactor = Platform.isIOS ? 1.5 : _mediaQueryData!.textScaleFactor;
    textScaleFactor = getTextScaleFactor(mediaQueryData.textScaleFactor);

    // textScaleFactor = 1.1;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal!) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical!) / 100;
    print('Text Scale' +
        textScaleFactor.toString() +
        " " +
        screenWidth.toString() +
        " " +
        screenHeight.toString());
    kfontSize10 = 10 * textScaleFactor!;
    kfontSize12 = 12 * textScaleFactor!;
    kfontSize14 = 14 * textScaleFactor!;
    kfontSize16 = 16 * textScaleFactor!;
    kfontSize18 = 18 * textScaleFactor!;
    kfontSize20 = 20 * textScaleFactor!;
    kfontSize24 = 24 * textScaleFactor!;
    kStyle12PrimaryColor = TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.w400,
        fontSize: kfontSize12);
    kStyle12 = TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize12);
    kStyle14 = TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize14);
    kStyle16 = TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize16);
    kStyle10 = TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize10);

    kStyle14W500 =
        TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize14);

    kStyle14PrimaryColor =
        TextStyle(fontSize: kfontSize14, color: kPrimaryColor);
    kStyle14Bold = TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: kfontSize14,
    );

    kStyle12W500 =
        TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize12);

    kStyle16Bold =
        TextStyle(fontWeight: FontWeight.w700, fontSize: kfontSize16);

    kStyle16W500 =
        TextStyle(fontSize: kfontSize16, fontWeight: FontWeight.w500);

    kStyle16PrimaryColor =
        TextStyle(fontSize: kfontSize16, color: kPrimaryColor);

    kStyle24Bold =
        TextStyle(fontWeight: FontWeight.bold, fontSize: kfontSize24);

    kStyle20Bold =
        TextStyle(fontWeight: FontWeight.bold, fontSize: kfontSize20);

    kStyle20W500 =
        TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize20);

    selectedTabTextStyle =
        kStyle16Bold.copyWith(color: kPrimaryColor, fontFamily: 'DM Sans');
    // kStyle16Bold.copyWith(color: kPrimaryColor, fontFamily: 'DM Sans');
    unSelectedTabTextStyle =
        kStyle16.copyWith(fontFamily: 'DM Sans', color: kGreyTextColor);

    kStyleAppBarTitle = kStyle14W500.copyWith(color: Colors.black);
    print("Screen Width : $screenWidth, Screen Height: $screenHeight");
  }

  double getTextScaleFactor(double original) {
    var logger = Logger();
    logger.d(original.toString() + "hellowwwww");
    // return 1.5;
    //  var min(a, b)
    if (original <= 1) {
      return 1;
    } else if (original >= 1.05) {
      return 1.05;
    } else {
      return original;
    }
// var textScaleFactor =
//         original < 1 ? 1 : mediaQueryData.textScaleFactor;
//         textScaleFactor =
//         original > 1.1 ? 1 : mediaQueryData.textScaleFactor;
  }
}

extension MediaQuerySizesNum on num {
  double get h => (this / 100) * SizeConfig.screenHeight;
  double get w => (this / 100) * SizeConfig.screenWidth;
}

extension MediaQuerySizesInt on int {
  double get h => (this / 100) * SizeConfig.screenHeight;
  double get w => (this / 100) * SizeConfig.screenWidth;
}

// const Color kPrimaryColor = Color(0xff3570B5);
// const double kfontSize18 = 18;
// const double kfontSize16 = 16;
// const double kfontSize12 = 12;
// const double kfontSize10 = 10;
// const double kfontSize20 = 20;
// const double kfontSize14 = 14;
// const double kfontSize24 = 24;

// const SizedBox kverticalMargin8 = const SizedBox(
//   height: 8,
// );
// const SizedBox kverticalMargin4 = const SizedBox(
//   height: 4,
// );

// const SizedBox kverticalMargin16 = const SizedBox(
//   height: 16,
// );

// const SizedBox kverticalMargin24 = const SizedBox(
//   height: 24,
// );

// const SizedBox kverticalMargin32 = const SizedBox(
//   height: 32,
// );
// const SizedBox kHorizontalMargin4 = const SizedBox(
//   width: 4,
// );
// const SizedBox kHorizontalMargin8 = const SizedBox(
//   width: 8,
// );
// const SizedBox kHorizontalMargin16 = const SizedBox(
//   width: 16,
// );
// const SizedBox kHorizontalMargin32 = const SizedBox(
//   width: 32,
// );
// const TextStyle kStyle12PrimaryColor = const TextStyle(
//     color: kPrimaryColor, fontWeight: FontWeight.w400, fontSize: kfontSize12);
// const TextStyle kStyle12 =
//     const TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize12);
// const TextStyle kStyle10 =
//     const TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize10);
// const TextStyle kStyle14W500 =
//     const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize14);
// const TextStyle kStyle14 = const TextStyle(fontSize: kfontSize14);

// const TextStyle kStyle14PrimaryColor =
//     const TextStyle(fontSize: kfontSize14, color: kPrimaryColor);

// const TextStyle kStyle12W500 =
//     const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize12);

// const TextStyle kStyle16Bold =
//     const TextStyle(fontWeight: FontWeight.w700, fontSize: kfontSize16);
// const TextStyle kStyle16 = const TextStyle(fontSize: kfontSize16);
// const TextStyle kStyle16W500 =
//     const TextStyle(fontSize: kfontSize16, fontWeight: FontWeight.w500);
// const TextStyle kStyle16PrimaryColor =
//     const TextStyle(fontSize: kfontSize16, color: kPrimaryColor);

// const TextStyle kStyle24Bold =
//     const TextStyle(fontWeight: FontWeight.bold, fontSize: kfontSize24);
// const TextStyle kStyle20Bold =
//     const TextStyle(fontWeight: FontWeight.bold, fontSize: kfontSize20);
// const TextStyle kStyle20W500 =
//     const TextStyle(fontWeight: FontWeight.w500, fontSize: kfontSize20);

// TextStyle selectedTabTextStyle =
//     kStyle16Bold.copyWith(color: kPrimaryColor, fontFamily: 'DM Sans');
// TextStyle unSelectedTabTextStyle = kStyle16.copyWith(fontFamily: 'DM Sans');

// Color? kShimmerBaseColor = Colors.grey[100];

// Color? kShimmerHighlightColor = Colors.grey[200];

// Color kGreyTextColor = Color(0xff696969);
