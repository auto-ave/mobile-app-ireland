import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';
import 'package:themotorwash/ui/widgets/store_search_tile.dart';
import 'package:themotorwash/ui/widgets/vehicle_dropdown.dart';
import 'package:themotorwash/utils/utils.dart';

class StoreListScreen extends StatefulWidget {
  final String city;
  final String title;
  final String? serviceTag;
  const StoreListScreen({
    Key? key,
    required this.city,
    required this.title,
    this.serviceTag,
  }) : super(key: key);
  static final String route = "/storeList";
  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  late StoreListBloc _storeListBloc;
  late GlobalLocationBloc _globalLocationBloc;
  List<StoreListModel> stores = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalLocationBloc =
        BlocProvider.of<GlobalLocationBloc>(context, listen: false);
    _storeListBloc = StoreListBloc(
        repository: RepositoryProvider.of<Repository>(context),
        globalLocationBloc: _globalLocationBloc);
    widget.serviceTag != null
        ? _storeListBloc.add(LoadStoreListByService(
            offset: 0, serviceTag: widget.serviceTag!, forLoadMore: false))
        : _storeListBloc
            .add(LoadNearbyStoreList(offset: 0, forLoadMore: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithBackButton(
          context: context,
          title: Text(
            widget.title,
            style: SizeConfig.kStyle14W500.copyWith(color: Colors.black),
          )),
      backgroundColor: Colors.white,
      body: LazyLoadScrollView(
        onEndOfPage: _loadMoreStores,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Stores near you",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            BlocConsumer<StoreListBloc, StoreListState>(
              bloc: _storeListBloc,
              listener: (_, state) {
                setState(
                    () {}); //TODO Find alternative for this workaround (Need setState for lazyloading to trigger)
              },
              builder: (context, state) {
                if (state is StoreListLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: loadingAnimation(),
                    ),
                  );
                }
                if (state is StoreListLoaded || state is MoreStoreListLoading) {
                  if (state is StoreListLoaded) {
                    stores = state.stores;
                  }
                  return stores.isEmpty
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text('No nearby store found'),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (BuildContext _, int index) {
                            final store = stores[index];
                            var tile = StoreSearchTile(
                              isNew: store.rating == null,
                              distance: store.distance!,
                              imageURL: store.thumbnail!,
                              rating: store.rating ?? 'unrated',
                              storeName: store.name,
                              startingFrom: store.servicesStart!,
                              storeSlug: store.storeSlug!,
                            );
                            if (state is MoreStoreListLoading &&
                                index == stores.length - 1) {
                              return LoadingMoreTile(tile: tile);
                            }
                            return tile;
                          },
                          childCount: stores.length,
                        ));
                }
                if (state is StoreListError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: ErrorScreen(
                        ctaType: ErrorCTA.reload,
                        onCTAPressed: () {
                          _storeListBloc.add(LoadNearbyStoreList(
                              offset: 0, forLoadMore: false));
                        },
                      ),
                    ),
                  );
                }
                return SliverFillRemaining(
                  child: Center(
                    child: loadingAnimation(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _loadMoreStores() {
    StoreListState currentState = _storeListBloc.state;
    if (!_storeListBloc.hasReachedMax(currentState, true)) {
      if (currentState is StoreListLoaded) {
        widget.serviceTag != null
            ? _storeListBloc.add(LoadStoreListByService(
                offset: stores.length,
                forLoadMore: true,
                serviceTag: widget.serviceTag!))
            : _storeListBloc.add(
                LoadNearbyStoreList(offset: stores.length, forLoadMore: true));
      }
    }
  }
}
// SliverAppBar(
//                 floating: true,
//                 expandedHeight: (24 + 40 + 24 + 40 + 8).toDouble(),
//                 //8+40+8+40
//                 automaticallyImplyLeading: false,
//                 backgroundColor: Colors.white,
//                 collapsedHeight: (24 + 40 + 24 + 40 + 8).toDouble(),
//                 flexibleSpace: Container(
//                   color: Colors.white,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 24, horizontal: 16),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: VehicleDropDown(
//                                 valueSelected: _selectedFilter,
//                                 hintText: "Vehicle Type",
//                                 onChangedSelected: (string) {
//                                   setState(() {
//                                     _selectedFilter = string;
//                                   });
//                                 },
//                                 options: _filters,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 16,
//                             ),
//                             Expanded(
//                                 child: VehicleDropDown(
//                               valueSelected: _selectedFilter,
//                               hintText: "Vehicle Type",
//                               onChangedSelected: (string) {
//                                 setState(() {
//                                   _selectedFilter = string;
//                                 });
//                               },
//                               options: _filters,
//                             )),
//                           ],
//                         ),
//                       ),
//                       SearchBar(focusNode: FocusNode(), onChanged: (asd) {})
//                     ],
//                   ),
//                 ),
//               ),
