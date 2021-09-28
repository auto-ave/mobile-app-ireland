import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/widgets/badge.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';

import '../../theme_constants.dart';

class StoreSearchTile extends StatelessWidget {
  final String imageURL;
  final String storeName;
  final String distance;
  final String? rating;
  final String startingFrom;
  final String storeSlug;
  final bool isNew;

  const StoreSearchTile(
      {required this.distance,
      required this.imageURL,
      required this.rating,
      required this.storeName,
      required this.startingFrom,
      required this.storeSlug,
      required this.isNew});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(StoreDetailScreen.route,
            arguments: StoreDetailArguments(storeSlug: storeSlug));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              placeholder: (_, __) {
                return Container(
                  child: ShimmerPlaceholder(),
                  width: 80,
                  height: 80,
                );
              },
              imageUrl: imageURL,
              imageBuilder: (context, imageProvider) => Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                ),
              ),
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
                  Text.rich(
                    TextSpan(children: [
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text.rich(
                    TextSpan(children: [
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            !isNew
                ? Row(
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
                        rating!,
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )
                : BadgeWidget(text: 'New'),
          ],
        ),
      ),
    );
  }
}
