import 'package:flutter/material.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_heading.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_info.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_map.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_popular_service_tile.dart';
import 'package:themotorwash/ui/widgets/store_tile.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: StoreHeading(
            name: store.name!,
            numberOfRatings: store.ratingCount!,
            rating: store.rating,
          )),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: StoreInfo(
            address: store.address!,
            // closingTime: store.storeClosingTime!,
            // openingTime: store.storeOpeningTime!,
            serviceStartsAt: "499", //TODO : todo
          )),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: StoreMap(
            latitute: store.latitude!,
            longitute: store.longitude!,
          )),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              "Popular Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopularServiceTile(),
                  PopularServiceTile(),
                  PopularServiceTile(),
                  PopularServiceTile(),
                  PopularServiceTile(),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              "You may also like",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return StoreTile(
              distance: "4",
              imageURL: 'assets/images/storeListImage.jpg',
              rating: '4.2',
              storeName: 'SuperDry Wash',
              startingFrom: "499",
              storeSlug: 'lol dont click this',
              //TODO : see it urself
            );
          },
          childCount: 20,
        ))
      ],
    );
  }
}
