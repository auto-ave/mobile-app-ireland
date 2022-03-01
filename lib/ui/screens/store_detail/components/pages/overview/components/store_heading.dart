import 'package:flutter/material.dart';
import 'package:themotorwash/main.dart';

import 'package:themotorwash/theme_constants.dart';

class StoreHeading extends StatelessWidget {
  final String name;
  final double? rating;
  final int numberOfRatings;
  final Function onPressedRating;
  const StoreHeading({
    Key? key,
    required this.name,
    this.rating,
    required this.numberOfRatings,
    required this.onPressedRating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: SizeConfig.kStyle20W500,
          ),
        ),
        rating != null
            ? GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onPressedRating();
                  mixpanel?.track('Store Overview Rating Pressed');
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        SizeConfig.kHorizontalMargin4,
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "${numberOfRatings.toString()}+ ratings",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
