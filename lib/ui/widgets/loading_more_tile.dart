import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/utils.dart';

class LoadingMoreTile extends StatelessWidget {
  final Widget tile;
  const LoadingMoreTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return tile;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: tile,
          width: double.infinity,
        ),
        SizeConfig.kverticalMargin16,
        SizedBox(
          child: CircularProgressIndicator(),
          height: 30,
          width: 30,
        ),
        SizeConfig.kverticalMargin16,
      ],
    );
  }
}
