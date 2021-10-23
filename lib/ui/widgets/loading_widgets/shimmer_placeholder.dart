import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';

class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: SizeConfig.kShimmerBaseColor!,
        highlightColor: SizeConfig.kShimmerHighlightColor!,
        child: Container(
          color: SizeConfig.kShimmerBaseColor,
        ));
  }
}
