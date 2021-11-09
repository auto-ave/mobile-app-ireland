import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';

class ExploreServicesLoadingTile extends StatelessWidget {
  const ExploreServicesLoadingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: SizeConfig.kShimmerBaseColor!,
          highlightColor: SizeConfig.kShimmerHighlightColor!,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey[300],
            ),
          ),
        ),
        SizeConfig.kverticalMargin8,
        Shimmer.fromColors(
          baseColor: SizeConfig.kShimmerBaseColor!,
          highlightColor: SizeConfig.kShimmerHighlightColor!,
          child: Container(
            height: 20,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[300],
            ),
          ),
        ),
      ],
    );
  }
}
