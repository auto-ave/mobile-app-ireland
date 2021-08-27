import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';

import '../../theme_constants.dart';

class StoreSearchTile extends StatelessWidget {
  final String imageURL;
  final String storeName;
  final String distance;
  final String rating;
  final String startingFrom;
  final String storeSlug;

  const StoreSearchTile(
      {required this.distance,
      required this.imageURL,
      required this.rating,
      required this.storeName,
      required this.startingFrom,
      required this.storeSlug});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(StoreDetailScreen.route,
            arguments: StoreDetailArguments(storeSlug: storeSlug));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageURL,
              width: 80,
              height: 80,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "$distance ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "from your location",
                        style: TextStyle(
                          color: const Color(0xff8D8D8D),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "services start @ ",
                        style: TextStyle(
                          color: Color(0xff8D8D8D),
                        ),
                      ),
                      TextSpan(
                        text: "₹$startingFrom",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  rating,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
