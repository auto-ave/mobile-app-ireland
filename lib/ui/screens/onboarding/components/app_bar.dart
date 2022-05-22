import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themotorwash/data/analytics/analytics_events.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';

class AppBarOnboardingScreen extends StatelessWidget with PreferredSizeWidget {
  const AppBarOnboardingScreen({Key? key}) : super(key: key);

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
                const EdgeInsets.only(right: 16.0, left: 20, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 30.w,
                ),
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
