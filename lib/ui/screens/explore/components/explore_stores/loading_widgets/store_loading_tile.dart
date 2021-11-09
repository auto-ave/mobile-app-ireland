import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';

class StoreLoadingTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 24,
                offset: Offset(0, 4),
                color: Color.fromRGBO(0, 0, 0, .16))
          ], borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: SizeConfig.kShimmerBaseColor!,
                highlightColor: SizeConfig.kShimmerHighlightColor!,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: SizeConfig.kShimmerBaseColor!,
                          highlightColor: SizeConfig.kShimmerHighlightColor!,
                          child: Container(
                            height: 20,
                            width: 200,
                            color: Colors.grey[300],
                          ),
                        ),
                        Spacer(),
                        Shimmer.fromColors(
                          baseColor: SizeConfig.kShimmerBaseColor!,
                          highlightColor: SizeConfig.kShimmerHighlightColor!,
                          child: Container(
                            height: 20,
                            width: 20,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    SizeConfig.kverticalMargin8,
                    Shimmer.fromColors(
                      baseColor: SizeConfig.kShimmerBaseColor!,
                      highlightColor: SizeConfig.kShimmerHighlightColor!,
                      child: Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
