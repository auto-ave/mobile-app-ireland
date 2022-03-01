import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExplorePicksLoading extends StatelessWidget {
  const ExplorePicksLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(children: [
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
      SliverPadding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
        sliver: SliverToBoxAdapter(
          child: Container(
            // height: 70.w,
            height: 200,
            // width: 200,
            // width: 200,
            child: ShimmerPlaceholder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
    ]);
  }
}
