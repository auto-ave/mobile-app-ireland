import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreFeaturedLoading extends StatelessWidget {
  const ExploreFeaturedLoading({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverToBoxAdapter(
          child: Container(
            height: (132 / 290) * 85.w,
            width: 85.w,
            child: ShimmerPlaceholder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ),
    ]);
  }
}
