import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_services/explore_services_tile.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreServicesGrid extends StatelessWidget {
  final List<ExploreServiceTile> items;
  const ExploreServicesGrid({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.)
    return MultiSliver(children: [
      SliverPadding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 16),
        sliver: SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Care your vehicle deserves!',
                style: SizeConfig.kStyle16Bold,
              ),
              Text(
                'Discover variety of services to take utmost care of your vehicle',
                style: SizeConfig.kStyle10
                    .copyWith(color: SizeConfig.kGreyTextColor),
              ),
            ],
          ),
        ),
      ),
      // SliverStaggeredGrid.count(
      //   crossAxisCount: 3,
      //   children: items.sublist(2),
      //   staggeredTiles:
      //       items.sublist(2).map((e) => StaggeredTile.fit(1)).toList(),
      // )
      // // SliverGrid(
      // //     delegate: SliverChildListDelegate(items),
      // //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      // //       mainAxisExtent: 130,
      // //       mainAxisSpacing: 16,
      // //       crossAxisCount: 3,
      // //     ))
      Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 32,
          // alignment: WrapAlignment.spaceAround,
          // crossAxisAlignment: WrapCrossAlignment.start,
          // alignment: WrapAlignment.start,

          children: items
              .map((e) => Padding(
                    padding: EdgeInsets.all(0),
                    child: e,
                  ))
              .toList(),
        ),
      ),
      SizeConfig.kverticalMargin16,
      // SliverGrid.count(
      //   crossAxisCount: 3,
      //   children: items,
      //   mainAxisSpacing: 8,
      //   crossAxisSpacing: 0,
      // childAspectRatio: SizeConfig.screenWidth> ,
      // ),
    ]);
  }
}
