import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class PopularServiceTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * .8,
        // height: MediaQuery.of(context).size.height * .27,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(17, 17, 17, 0.06),
                  blurRadius: 24,
                  offset: Offset(0, 20))
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Premium Carwash",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: SizeConfig.kPrimaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Praesent eu efficitur lectus. Integer ac efficitur tortor. Sed dictum turpis id est luctus, ut pretium magna varius. Sed ullamcorper, nisl in auctor rhoncus, mi risus blandit mauris, vitae rutrum elit erat ut nulla.",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "More info",
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: SizeConfig.kPrimaryColor),
            ),
            Row(
              children: <Widget>[
                Text("₹ 1299"),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                      backgroundColor:
                          MaterialStateProperty.all(SizeConfig.kPrimaryColor)),
                  child: Text(
                    "View all services",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
