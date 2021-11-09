import 'package:flutter/material.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_stores/store_tile.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreStoresList extends StatelessWidget {
  final List<StoreListModel> stores;
  final StoreListState state;
  const ExploreStoresList({Key? key, required this.state, required this.stores})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(children: [
      SliverPadding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 8),
        sliver: SliverToBoxAdapter(
            child: Text(
          'Popular stores near you',
          style: SizeConfig.kStyle16Bold,
        )),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
        (_, index) {
          var store = stores[index];
          var tile = StoreTile(
            address: store.address!,
            distance: store.distance!,
            imageURL: store.thumbnail!,
            rating: store.rating,
            storeName: store.name,
            startingFrom: store.servicesStart!,
            storeSlug: store.storeSlug!,
          );
          if (state is MoreStoreListLoading && index == stores.length - 1) {
            return LoadingMoreTile(tile: tile);
          }
          return tile;
        },
        childCount: stores.length,
      ))
    ]);
  }
}
