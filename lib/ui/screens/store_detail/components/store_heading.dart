import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class StoreHeading extends StatelessWidget {
  final String name;
  final double? rating;
  final int numberOfRatings;
  const StoreHeading({
    Key? key,
    required this.name,
    required this.rating,
    required this.numberOfRatings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            name,
            style: kStyle20W500,
          ),
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                rating != null
                    ? Icon(
                        Icons.star,
                        color: Colors.orange,
                      )
                    : Container(),
                Text(
                  rating == null ? 'Unrated' : rating.toString(),
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
        )
      ],
    );
  }
}
