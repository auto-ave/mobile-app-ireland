import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_services/explore_services_grid.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_services/loading_widgets/explore_services_loading_tile.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreServicesGridLoading extends StatelessWidget {
  const ExploreServicesGridLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Shimmer.fromColors(
              baseColor: SizeConfig.kShimmerBaseColor!,
              highlightColor: SizeConfig.kShimmerHighlightColor!,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 25,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 32,
            // alignment: WrapAlignment.spaceAround,
            // crossAxisAlignment: WrapCrossAlignment.start,

            children: List.filled(6, ExploreServicesLoadingTile()),
          ),
        ),
        SizeConfig.kverticalMargin16,
        // SliverGrid.count(
        //   crossAxisCount: 3,
        //   children: List.filled(6, ExploreServicesLoadingTile()),
        //   mainAxisSpacing: 8,
        //   crossAxisSpacing: 0,

        //   // childAspectRatio: 1.5,
        // ),
      ],
    );
  }
}
