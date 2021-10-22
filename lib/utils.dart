import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rive/rive.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';

getTimeOfDayFromString(String s) {
  List<String> splitted = s.split(':');
  return TimeOfDay(
    hour: int.parse(splitted[0]),
    minute: int.parse(splitted[1]),
  );
}

showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(text),
    duration: Duration(milliseconds: 2000),
  ));
}

PreferredSizeWidget getAppBarWithBackButton(
    {required BuildContext context, Widget? title}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
    title: title,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
      onPressed: () => Navigator.maybePop(context),
    ),
    actionsIconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

PreferredSizeWidget getAppBarLoginScreen(
    {required BuildContext context, Widget? title}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
    elevation: 0,
    backgroundColor: Colors.white,
    actions: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16.0, left: 8, top: 8, bottom: 8),
          child: Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * .3,
              ),
              Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, ExploreScreen.route, (route) => false),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skip',
                      style: SizeConfig.kStyle16PrimaryColor,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: SizeConfig.kPrimaryColor,
                      size: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    ],
  );
}

Widget loadingAnimation() {
  // return SizedBox(
  //   width: 300,
  //   height: 300,
  //   child: RiveAnimation.asset(
  //     'assets/animations/clean_the_car.riv',
  //   ),
  // );
  final spinkit = SpinKitThreeInOut(
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isEven ? SizeConfig.kPrimaryColor : Color(0xffbfdcff),
          ),
        ),
      );
    },
  );
  return spinkit;
}

String? validateEmail(String? email) {
  if (email != null) {
    if (EmailValidator.validate(email)) {
      return null;
    }
    return 'Enter a valid email';
  }
  return 'Enter a valid email';
}

String? validatePhone(String? phoneNumber) {
  if (phoneNumber != null) {
    if (phoneNumber.length == 10 && RegExp(r'^[0-9]+$').hasMatch(phoneNumber)) {
      return null;
    }
  }
  return 'Enter a valid phone number';
}
