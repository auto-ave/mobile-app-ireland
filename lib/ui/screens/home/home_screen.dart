import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/home/components/location_bar.dart';
import 'package:themotorwash/ui/screens/home/components/motto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final String route = '/homeScreen';

  @override
  Widget build(BuildContext context) {
    final height = 100.h;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/homeBack.jpg"),
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                    height: (height -
                            SizeConfig.mediaQueryData.padding.bottom -
                            SizeConfig.mediaQueryData.padding.top) *
                        .26),
                Motto(),
                SizedBox(
                    height: (height -
                            SizeConfig.mediaQueryData.padding.bottom -
                            SizeConfig.mediaQueryData.padding.top) *
                        .06),
                LocationBar(),
              ],
            ),
          ),
          /* add child content here */
        ),
      ),
    );
  }
}
