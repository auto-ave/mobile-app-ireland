import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/sort_param.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/screens/store_list/components/store_list_tile.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';
import 'package:themotorwash/ui/widgets/store_search_tile.dart';
import 'package:themotorwash/ui/widgets/vehicle_dropdown.dart';
import 'package:themotorwash/utils/packages/flexible_title_visibility_controller/flexible_title_visibility_controller.dart';
import 'package:themotorwash/utils/utils.dart';

class StoreListScreen extends StatefulWidget {
  final String city;
  final String title;
  final String imageUrl;
  final String? serviceTag;
  const StoreListScreen({
    Key? key,
    required this.city,
    required this.title,
    required this.imageUrl,
    this.serviceTag,
  }) : super(key: key);
  static final String route = "/storeList";
  @override
  _StoreListScreenState createState() {
    FlutterUxcam.tagScreenName(route);
    return _StoreListScreenState();
  }
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
      // appBar: getAppBarWithBackButton(
      //     context: context,
      //     title: Text(
      //       widget.title,
      //       style: SizeConfig.kStyle14W500.copyWith(color: Colors.black),
      //     )),
      bottomNavigationBar: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: 1.5)),
        child: CommonTextButton(
            onPressed: () {
              showSortBottomSheet(context);
            },
            child: Text("Sort By",
                style: SizeConfig.kStyle14W500.copyWith(color: Colors.black)),
            backgroundColor: Colors.white,
            buttonSemantics: 'Sort'),
      ),
      backgroundColor: Colors.white,
      body: LazyLoadScrollView(
        onEndOfPage: _loadMoreStores,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              collapsedHeight: 60,
              systemOverlayStyle:
                  SystemUiOverlayStyle(statusBarColor: Colors.transparent),
              // floating: false,
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    textColor: Colors.grey,
                    child: Icon(
                      Icons.chevron_left,
                      size: 30,
                    ),
                    shape: CircleBorder(),
                    minWidth: 38,
                  ),
                ),
                Spacer(),
              ],
              expandedHeight:
                  100.w * 9 / 16 - SizeConfig.mediaQueryData.padding.top,
              flexibleSpace: FlexibleSpaceBar(
                title: FlexibleTitleVisibilityController(
                  child: Text(
                    widget.title ?? "",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    textScaleFactor: 1,
                  ),
                ),
                centerTitle: false,
                background: Container(
                  color: Colors.white,
                  child: CachedNetworkImage(
                    placeholder: (_, __) {
                      return ShimmerPlaceholder();
                    },
                    imageUrl: widget.imageUrl,
                    width: 100.w,
                    height: 100.w * 9 / 16,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(top: 16, left: 20, bottom: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  widget.title,
                  style: SizeConfig.kStyle20Bold,
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
                            var tile = StoreListTile(
                              isNew: store.rating == null,
                              distance: store.distance!,
                              imageURL: store.thumbnail!,
                              rating: store.rating ?? 'unrated',
                              storeName: store.name,
                              startingFrom: store.servicesStart ?? '',
                              storeSlug: store.storeSlug!,
                              serviceTag: widget.serviceTag,
                              taggedServices: store.taggedServices,
                              address: store.address ?? "",
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

  showSortBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        // isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (context) {
          return StatefulBuilder(builder: (context, setModalState) {
            return SortModalSheet(
                sortParams: [PriceHighToLow(), PriceLowToHigh(), Distance()],
                storeListBloc: _storeListBloc,
                selectedSortParam: _storeListBloc.sortParam,
                serviceTag: widget.serviceTag!);
          });
        });
  }
}

class SortModalSheet extends StatelessWidget {
  final List<SortParam> sortParams;
  final SortParam selectedSortParam;
  final StoreListBloc storeListBloc;
  final String serviceTag;
  const SortModalSheet(
      {Key? key,
      required this.sortParams,
      required this.storeListBloc,
      required this.selectedSortParam,
      required this.serviceTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        //  DraggableScrollableSheet(
        //   builder: (context, controller) {
        //     return
        Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: sortParams.asMap().entries.map((entry) {
                final index = entry.key;
                final sortParam = entry.value;
                return SortItemTile(
                    title: sortParam.toTitle(),
                    onTap: () {
                      storeListBloc.add(ChangeSortParam(
                          sortParam: sortParams[index],
                          serviceTag: serviceTag));
                      Navigator.pop(context);
                    },
                    isSelected: sortParams[index].toParam() ==
                        selectedSortParam.toParam());
              }).toList(),
            ));
    // },
    // initialChildSize: .4,
    // );
  }
}

// SortItemTile(
//                   title: sortParams[index].toTitle(),
// onTap: () {
//   storeListBloc.add(ChangeSortParam(
//       sortParam: sortParams[index],
//       serviceTag: serviceTag));
//   Navigator.pop(context);
// },
// isSelected: sortParams[index].toParam() ==
//     selectedSortParam.toParam());
class SortItemTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  const SortItemTile(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.w,
        decoration: BoxDecoration(color: isSelected ? Color(0xffE5F1FF) : null),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Text(title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected ? SizeConfig.kPrimaryColor : Colors.black)),
      ),
    );
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
