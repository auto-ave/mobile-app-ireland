import 'package:flutter/material.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';

class LocationBar extends StatelessWidget {
  const LocationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter Location",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(25, 32, 56, 0.08), blurRadius: 24)
              ]),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Icon(
                Icons.location_on,
                color: SizeConfig.kPrimaryColor,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Text(
                "Delhi",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              )),
              Text(
                "Use GPS",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(StoreListScreen.route,
                          arguments:
                              StoreListArguments(city: 'bpl', title: ''));
                    },
                    child: Text("Find"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(SizeConfig.kPrimaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.zero,
                            bottomLeft: Radius.zero,
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      )),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
