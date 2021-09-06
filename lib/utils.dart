import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(text),
    duration: Duration(seconds: 1),
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
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, ExploreScreen.route, (route) => false),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skip',
                      style: kStyle16PrimaryColor,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: kPrimaryColor,
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
