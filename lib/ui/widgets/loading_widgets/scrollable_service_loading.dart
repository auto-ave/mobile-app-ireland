import 'package:flutter/material.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/service_search_loading_tile.dart';

class ScrollableServiceLoading extends StatelessWidget {
  const ScrollableServiceLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.filled(3, ServiceSearchLoadingTile()),
      ),
    );
  }
}
