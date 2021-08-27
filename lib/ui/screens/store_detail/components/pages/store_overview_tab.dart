import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_heading.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_info.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_map.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_popular_service_tile.dart';
import 'package:themotorwash/ui/widgets/store_search_tile.dart';

class StoreOverviewTab extends StatelessWidget {
  final BuildContext nestedScrollContext;
  final String storeSlug;
  final Store store;
  StoreOverviewTab(
      {required this.nestedScrollContext,
      required this.storeSlug,
      required this.store});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber
          // above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
              nestedScrollContext),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: StoreHeading(
            name: store.name!,
            numberOfRatings: store.ratingCount!,
            rating: store.rating,
          )),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: StoreInfo(
            address: store.address!,
            // closingTime: store.storeClosingTime!,
            // openingTime: store.storeOpeningTime!,
            serviceStartsAt: "₹499", //TODO : todo
          )),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          sliver: SliverToBoxAdapter(
              child: Text(
            'About',
            style: kStyle20W500,
          )),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          sliver: SliverToBoxAdapter(
              child: Text(
            store.description!,
            style: kStyle12,
          )),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: StoreMap(
            latitute: store.latitude!,
            longitute: store.longitude!,
          )),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () async {
                final availableMaps = await MapLauncher.installedMaps;
                print(
                    availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                await availableMaps.first.showDirections(
                    destination: Coords(store.latitude!, store.longitude!));
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/map.svg'),
                  kHorizontalMargin8,
                  Text(
                    'Open in maps',
                    style: kStyle16.copyWith(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
// SliverPadding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           sliver: SliverToBoxAdapter(
//             child: Text(
//               "You may also like",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//             ),
//           ),
//         ),
//         SliverList(
//             delegate: SliverChildBuilderDelegate(
//           (BuildContext context, int index) {
//             return StoreSearchTile(
//               distance: "4",
//               imageURL: 'assets/images/storeListImage.jpg',
//               rating: '4.2',
//               storeName: 'SuperDry Wash',
//               startingFrom: "499",
//               storeSlug: 'lol dont click this',
//               //TODO : see it urself
//             );
//           },
//           childCount: 20,
//         ))