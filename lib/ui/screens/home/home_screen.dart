import 'package:flutter/material.dart';
import 'package:themotorwash/ui/screens/home/components/location_bar.dart';
import 'package:themotorwash/ui/screens/home/components/motto.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
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
                            MediaQuery.of(context).padding.bottom -
                            MediaQuery.of(context).padding.top) *
                        .26),
                Motto(),
                SizedBox(
                    height: (height -
                            MediaQuery.of(context).padding.bottom -
                            MediaQuery.of(context).padding.top) *
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
