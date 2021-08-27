import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StoreSearchLoadingTile extends StatelessWidget {
  const StoreSearchLoadingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey,
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey,
                  child: Container(
                    height: 20,
                    width: 150,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey,
                  child: Container(
                    height: 20,
                    width: 30,
                    color: Colors.grey[300],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey,
                  child: Container(
                    height: 20,
                    width: 100,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey,
            child: Container(
              height: 20,
              width: 50,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
