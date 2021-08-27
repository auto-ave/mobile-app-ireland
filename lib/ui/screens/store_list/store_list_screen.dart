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
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';
import 'package:themotorwash/ui/widgets/store_search_tile.dart';
import 'package:themotorwash/ui/widgets/vehicle_dropdown.dart';
import 'package:themotorwash/utils.dart';

class StoreListScreen extends StatefulWidget {
  final String city;
  final String title;
  const StoreListScreen({
    Key? key,
    required this.city,
    required this.title,
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
    _storeListBloc.add(LoadNearbyStoreList(offset: 0, forLoadMore: false));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    return SafeArea(
      child: Scaffold(
        appBar: getAppBarWithBackButton(
            context: context,
            title: Text(
              widget.title,
              style: kStyle14.copyWith(color: Colors.black),
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
              BlocBuilder<StoreListBloc, StoreListState>(
                bloc: _storeListBloc,
                builder: (context, state) {
                  if (state is StoreListLoading) {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is StoreListLoaded ||
                      state is MoreStoreListLoading) {
                    if (state is StoreListLoaded) {
                      stores = state.stores;
                    }
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext _, int index) {
                        final store = stores[index];
                        var tile = StoreSearchTile(
                          distance: store.distance!,
                          imageURL: store.thumbnail!,
                          rating: store.rating ?? "4.5",
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
                        child: Text("Failed to load"),
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _loadMoreStores() {
    StoreListState currentState = _storeListBloc.state;
    if (!_storeListBloc.hasReachedMax(currentState)) {
      if (currentState is StoreListLoaded) {
        _storeListBloc
            .add(LoadNearbyStoreList(offset: stores.length, forLoadMore: true));
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