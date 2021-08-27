import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themotorwash/theme_constants.dart';

class ServiceSearchLoadingTile extends StatelessWidget {
  const ServiceSearchLoadingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
            ),
          ),
          kverticalMargin8,
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[400]!,
            child: Container(
              height: 20,
              width: 70,
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
