import 'package:flutter/material.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/service_search_loading_tile.dart';

class ScrollableServiceLoading extends StatelessWidget {
  final bool showTitle;
  const ScrollableServiceLoading({
    Key? key,
    required this.showTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        showTitle
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  'Services',
                  style: SizeConfig.kStyle14W500
                      .copyWith(color: SizeConfig.kPrimaryColor),
                ),
              )
            : Container(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[SizeConfig.kHorizontalMargin16] +
                List.filled(3, ServiceSearchLoadingTile()),
          ),
        ),
      ],
    );
  }
}
