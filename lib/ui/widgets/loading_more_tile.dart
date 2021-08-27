import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class LoadingMoreTile extends StatelessWidget {
  final Widget tile;
  const LoadingMoreTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tile,
        kverticalMargin8,
        CircularProgressIndicator(),
        kverticalMargin8,
      ],
    );
    ;
  }
}
