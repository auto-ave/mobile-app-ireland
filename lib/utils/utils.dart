import 'package:another_flushbar/flushbar.dart';
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
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        // statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light),
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
      SizedBox(
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

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

extension Rupees on String {
  String rupees() => "₹" + this;
}