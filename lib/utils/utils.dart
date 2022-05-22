import 'package:another_flushbar/flushbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:rive/rive.dart';
import 'package:themotorwash/data/analytics/analytics_events.dart';
import 'package:themotorwash/main.dart';
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
  // ScaffoldMessenger.of(context).removeCurrentSnackBar();
  Flushbar(
    message: text,
    // icon: Icon(
    //   Icons.info_outline,
    //   size: 28.0,
    //   color: Colors.blue[300],
    // ),
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    // leftBarIndicatorColor: Colors.blue[300],
  )..show(context);
  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //   margin: EdgeInsets.only(
  //       bottom: MediaQuery.of(context).size.height -
  //           MediaQuery.of(context).viewInsets.top -
  //           160,
  //       right: 20,
  //       left: 20),
  //   behavior: SnackBarBehavior.floating,
  //   content: Text(
  //     text,
  //   ),
  //   duration: Duration(milliseconds: 2000),
  // ));
}

PreferredSizeWidget getAppBarWithBackButton(
    {required BuildContext context, Widget? title, List<Widget>? actions}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    title: title,
    actions: actions,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
      onPressed: () => Navigator.maybePop(context),
    ),
    actionsIconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

class AppBarLoginScreen extends StatelessWidget with PreferredSizeWidget {
  const AppBarLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: 0,
      // brightness: Brightness.light,
      backgroundColor: Colors.white,
      actions: [
        SizedBox(
          width: 100.w,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20, top: 8, bottom: 8),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 30.w,
                ),
                Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // mixpanel?.track(SkipLoginAnalytics().eventName());
                    Navigator.pushNamedAndRemoveUntil(
                        context, ExploreScreen.route, (route) => false);
                  },
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

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(55);
}

PreferredSizeWidget getAppBarLoginScreen(
    {required BuildContext context, Widget? title}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    elevation: 0,
    // brightness: Brightness.light,
    backgroundColor: Colors.white,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 100.w,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 16.0, left: 8, top: 8, bottom: 8),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 30.w,
                ),
                Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    // mixpanel?.track(SkipLoginAnalytics().eventName());
                    Navigator.pushNamedAndRemoveUntil(
                        context, ExploreScreen.route, (route) => false);
                  },
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

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

extension StringUtils on String {
  String rupees() => "₹" + this;
}

extension IntUtils on int {
  String ordinalSuffix() {
    int i = this;
    var j = i % 10, k = i % 100;
    if (j == 1 && k != 11) {
      return i.toString() + "st";
    }
    if (j == 2 && k != 12) {
      return i.toString() + "nd";
    }
    if (j == 3 && k != 13) {
      return i.toString() + "rd";
    }
    return i.toString() + "th";
  }
}

void autoaveLog(String log) {
  Logger().d(log);
}

class BadgeCharColors {
  int a = "a".codeUnitAt(0);
  int z = "z".codeUnitAt(0);
  List<BadgeColors> badgeColors = [
    BadgeColors(
        textColor: Color(0xff026C00), backgroundColor: Color(0xffDBFFE5)),
    BadgeColors(
        backgroundColor: Color(0xffF1FFDB), textColor: Color(0xff436C00)),
    BadgeColors(
        backgroundColor: Color(0xffEAF4FF), textColor: Color(0xff3570B5))
  ];
  // List<MaterialColor> colors = [
  //   Colors.cyan,
  //   Colors.deepOrange,
  //   Colors.purple,
  //   Colors.orange,
  //   Colors.amber,
  //   Colors.lightBlue,
  //   Colors.deepPurple,
  //   Colors.indigo,
  //   Colors.orange,
  //   Colors.pink,
  //   Colors.grey,
  //   Colors.blue,
  // ];

  BadgeColors getColorForChar(String string) {
    autoaveLog(string);
    int x = string.toLowerCase().codeUnitAt(0);
    int toCompare = a + 3;

    for (int i = 0; i < 3; i++) {
      if (x < toCompare) {
        autoaveLog('$x < $toCompare');
        return badgeColors[i];
      }
      toCompare = toCompare + 3;
    }
    return badgeColors.last;
  }
}
