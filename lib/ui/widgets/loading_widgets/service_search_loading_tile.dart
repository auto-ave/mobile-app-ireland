import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:themotorwash/theme_constants.dart';

class ServiceSearchLoadingTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: SizeConfig.kShimmerBaseColor!,
            highlightColor: SizeConfig.kShimmerHighlightColor!,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
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
      ),
    );
  }
}
