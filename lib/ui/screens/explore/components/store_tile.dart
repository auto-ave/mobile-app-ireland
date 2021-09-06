import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';

class StoreTile extends StatelessWidget {
  final String imageURL;
  final String storeName;
  final String distance;
  final String? rating;
  final String startingFrom;
  final String storeSlug;
  final String address;
  const StoreTile({
    Key? key,
    required this.imageURL,
    required this.storeName,
    required this.distance,
    required this.rating,
    required this.startingFrom,
    required this.storeSlug,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, StoreDetailScreen.route,
          arguments: StoreDetailArguments(storeSlug: storeSlug)),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  color: Color.fromRGBO(0, 0, 0, .25))
            ], borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      placeholder: (_, __) {
                        return ShimmerPlaceholder();
                      },
                      height: 200,
                      imageUrl: imageURL,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              distance,
                              style: TextStyle(color: Colors.white),
                            ),
                            alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(4),
                                color: Color.fromRGBO(0, 0, 0, 0.35))),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: kStyle14SemiBold,
                      ),
                      kverticalMargin4,
                      Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kStyle12.copyWith(color: Color(0xff696969)),
                      ),
                      kverticalMargin4,
                      Divider(
                        thickness: 1,
                        height: 8,
                      ),
                      Row(
                        children: [
                          rating != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(rating!),
                                    kHorizontalMargin4,
                                    Text("•"),
                                    kHorizontalMargin4,
                                  ],
                                )
                              : Container(),
                          Text('Starts from ₹$startingFrom')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:themotorwash/navigation/arguments.dart';
// import 'package:themotorwash/theme_constants.dart';
// import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';

// class StoreTile extends StatelessWidget {
//   final String imageURL;
//   final String storeName;
//   final String distance;
//   final String rating;
//   final String startingFrom;
//   final String storeSlug;
//   const StoreTile({
//     Key? key,
//     required this.imageURL,
//     required this.storeName,
//     required this.distance,
//     required this.rating,
//     required this.startingFrom,
//     required this.storeSlug,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => Navigator.pushNamed(context, StoreDetailScreen.route,
//           arguments: StoreDetailArguments(storeSlug: storeSlug)),
//       child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Container(
//             clipBehavior: Clip.hardEdge,
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   blurRadius: 24,
//                   offset: Offset(0, 4),
//                   color: Color.fromRGBO(0, 0, 0, .16))
//             ], borderRadius: BorderRadius.circular(5)),
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     CachedNetworkImage(
//                       height: 250,
//                       imageUrl: imageURL,
//                       width: MediaQuery.of(context).size.width,
//                       fit: BoxFit.fill,
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                             padding: EdgeInsets.all(8),
//                             child: Text(
//                               distance,
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             alignment: Alignment.bottomRight,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(4),
//                                 color: Color.fromRGBO(0, 0, 0, 0.25))),
//                       ),
//                     )
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(5),
//                           bottomRight: Radius.circular(5)),
//                       color: Colors.white),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(storeName),
//                           Spacer(),
//                           Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           ),
//                           Text(rating)
//                         ],
//                       ),
//                       RichText(
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         text: TextSpan(children: [
//                           TextSpan(
//                             text: "services start @ ₹",
//                             style: TextStyle(
//                               color: Color(0xff8D8D8D),
//                             ),
//                           ),
//                           TextSpan(
//                             text: startingFrom,
//                             style: TextStyle(
//                                 color: kPrimaryColor,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ]),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }
// }
