import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';

import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/blocs/location_functions/bloc/location_functions_bloc.dart';
import 'package:themotorwash/blocs/search_services/search_services_bloc.dart';
import 'package:themotorwash/blocs/search_stores/search_stores_bloc.dart';
import 'package:themotorwash/data/models/location_model.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/grant_location_permission_screen.dart';
import 'package:themotorwash/ui/screens/explore/components/store_tile.dart';
import 'package:themotorwash/ui/screens/explore/components/search_overlay.dart';
import 'package:themotorwash/ui/screens/explore/components/search_service_tile.dart';
import 'package:themotorwash/ui/screens/store_detail/components/cart_bottom_sheet.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/widgets/bottom_cart_tile.dart';
import 'package:themotorwash/ui/widgets/drawer.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/service_search_loading_tile.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/store_loading_tile.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';
import 'package:themotorwash/utils.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);
  static final String route = '/exploreScreen';

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  FocusNode _node = FocusNode();
  bool _showSearch = false;
  late StoreListBloc _storeListBloc;
  late GlobalLocationBloc _globalLocationBloc;
  late SearchServicesBloc _searchServicesBloc;
  late SearchServicesBloc _privateSearchServicesBloc;
  late SearchStoresBloc _searchStoresBloc;
  final TextEditingController textController = TextEditingController();
  String currentText = "";
  List<StoreListModel> stores = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  late CartFunctionBloc _cartFunctionBloc;
  late GlobalAuthBloc _globalAuthBloc;

  @override
  void initState() {
    super.initState();

    Repository repository = RepositoryProvider.of<Repository>(context);
    _globalLocationBloc = BlocProvider.of<GlobalLocationBloc>(context);
    _storeListBloc = StoreListBloc(
        repository: repository, globalLocationBloc: _globalLocationBloc);
    _globalAuthBloc = BlocProvider.of<GlobalAuthBloc>(context);
    _globalLocationBloc.add(GetCurrentUserLocation());
    _searchServicesBloc = SearchServicesBloc(repository: repository);
    _privateSearchServicesBloc = SearchServicesBloc(repository: repository);
    _privateSearchServicesBloc
        .add(SearchServices(query: '', forLoadMore: false, offset: 0));
    _searchStoresBloc = SearchStoresBloc(
        repository: repository, globalLocationBloc: _globalLocationBloc);
    _node.addListener(() {
      setState(() {
        _node.hasFocus ? _showSearch = true : _showSearch = false;
      });
    });
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
    if (_globalAuthBloc.state is Authenticated) {
      print('if called');
      _cartFunctionBloc.add(GetCart());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("helofrom" + MediaQuery.of(context).padding.top.toString());
    return WillPopScope(
      onWillPop: () async {
        if (_node.hasFocus) {
          _node.unfocus();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<GlobalLocationBloc, GlobalLocationState>(
              bloc: _globalLocationBloc,
              listener: (context, state) {
                if (state is LocationSet) {
                  _storeListBloc
                      .add(LoadNearbyStoreList(offset: 0, forLoadMore: false));
                }
              },
              builder: (_, state) {
                if (state is LocationSet) {
                  return _buildScreen(state);
                }
                if (state is LocationPermissionError) {
                  return GrantLocationPermissionScreen(
                    globalLocationBloc: _globalLocationBloc,
                    forPermission: true,
                  );
                }
                if (state is LocationServiceNotEnabledError) {
                  return GrantLocationPermissionScreen(
                    globalLocationBloc: _globalLocationBloc,
                    forPermission: false,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  _buildScreen(LocationSet locationState) {
    return Scaffold(
      appBar: !_showSearch ? _buildAppBar(locationState.location) : null,
      endDrawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: SearchBar(
              textController: textController,
              onChanged: (value) {
                if (value.trim() != '' && currentText != value) {
                  _searchServicesBloc.add(SearchServices(
                      query: value, forLoadMore: false, offset: 0));
                  _searchStoresBloc.add(SearchStores(
                      query: value, forLoadMore: false, offset: 0));
                }
                if (value.trim() == '') {
                  _searchServicesBloc.add(YieldUninitializedState());
                }
                currentText = value;
              },
              focusNode: _node,
              hintText: 'Search services, stores...',
            ),
          ),
          Expanded(
              child: _showSearch
                  ? BlocBuilder<SearchServicesBloc, SearchServicesState>(
                      bloc: _searchServicesBloc,
                      builder: (context, state) {
                        if (state is SearchServicesUninitialized) {
                          return Center(
                            child: SvgPicture.asset(
                                'assets/images/search_placeholder.svg'),
                          );
                        }
                        return SearchOverlay(
                          textController: textController,
                          searchServicesBloc: _searchServicesBloc,
                          searchStoresBloc: _searchStoresBloc,
                        );
                      },
                    )
                  : _buidExploreSection())
        ],
      ),
    );
  }

  void _onRefresh() async {
    if (_globalLocationBloc.state is LocationSet) {
      _storeListBloc.add(LoadNearbyStoreList(offset: 0, forLoadMore: false));
      _privateSearchServicesBloc
          .add(SearchServices(query: '', forLoadMore: false, offset: 0));
    }
  }

  Widget _buidExploreSection() {
    return LazyLoadScrollView(
        onEndOfPage: _loadMoreStores,
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,

          header: ClassicHeader(
            completeText: '',
            completeIcon: null,
            refreshingText: '',
            releaseText: '',
            idleText: '',
            completeDuration: Duration(milliseconds: 0),
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          // onLoading: _onLoading,
          child: CustomScrollView(slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Services',
                  style: kStyle20Bold.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            BlocBuilder<SearchServicesBloc, SearchServicesState>(
              bloc: _privateSearchServicesBloc,
              builder: (context, state) {
                if (state is LoadingSearchServicesResult) {
                  return SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.filled(3, ServiceSearchLoadingTile()),
                    ),
                  );
                }
                if (state is SearchedServicesResult) {
                  return SliverToBoxAdapter(
                    child: state.searchedServices.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[kHorizontalMargin16] +
                                    state.searchedServices
                                        .map((e) => SearchServiceTile(
                                              imageUrl: e.thumbnail!,
                                              serviceName: e.name!,
                                            ))
                                        .toList(),
                              ),
                            ),
                          )
                        : Container(
                            child:
                                Center(child: Text('No services to display')),
                            width: double.infinity,
                            height: 100,
                          ),
                  );
                }
                if (state is SearchedServicesError) {}
                return SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.filled(3, ServiceSearchLoadingTile()),
                  ),
                );
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                  child: Text(
                'Carwashes near you',
                style: kStyle20Bold.copyWith(fontWeight: FontWeight.w500),
              )),
            ),
            BlocConsumer<StoreListBloc, StoreListState>(
                listener: (_, state) {
                  if (state is StoreListLoaded) {
                    _refreshController.refreshCompleted();
                  }
                },
                bloc: _storeListBloc,
                builder: (context, state) {
                  if (state is StoreListLoaded ||
                      state is MoreStoreListLoading) {
                    if (state is StoreListLoaded) {
                      stores = state.stores;
                    }
                    return SliverList(
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
                        if (state is MoreStoreListLoading &&
                            index == stores.length - 1) {
                          return LoadingMoreTile(tile: tile);
                        }
                        return tile;
                      },
                      childCount: stores.length,
                    ));
                  }
                  return SliverList(
                    delegate: SliverChildListDelegate(
                      List.filled(4, StoreLoadingTile()),
                    ),
                  );
                })
          ]),
        ));
  }

  _showCartSheet({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (_) {
          return CartBottomSheet();
        });
  }

  void _loadMoreStores() {
    StoreListState currentState = _storeListBloc.state;
    if (!_storeListBloc.hasReachedMax(currentState, true)) {
      if (currentState is StoreListLoaded) {
        _storeListBloc
            .add(LoadNearbyStoreList(offset: stores.length, forLoadMore: true));
      }
    }
  }

  PreferredSizeWidget _buildAppBar(LocationModel locationModel) {
    return AppBar(
      elevation: 0,
      actionsIconTheme: IconThemeData(color: kPrimaryColor),
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          GestureDetector(
            onTap: () =>
                showSnackbar(context, 'We currently only serve in Banglore'),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  locationModel.city,
                  style: kStyle16PrimaryColor,
                ),
              ],
            ),
          ),
          Spacer(),
          BlocConsumer<GlobalAuthBloc, GlobalAuthState>(
            listener: (_, state) {
              if (state is Authenticated) {
                print('listener called');
                _cartFunctionBloc.add(GetCart());
              }
            },
            bloc: _globalAuthBloc,
            builder: (context, state) {
              if (state is Authenticated) {
                return GestureDetector(
                  onTap: () => _showCartSheet(context: context),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.shoppingCart,
                        color: kPrimaryColor,
                      ),
                      Positioned(
                        top: -4,
                        right: -4,
                        child: BlocBuilder<CartFunctionBloc, CartFunctionState>(
                          bloc: _cartFunctionBloc,
                          builder: (context, state) {
                            int? count;

                            if (state is CartItemAdded) {
                              count = state.cart.items!.length;
                            }

                            if (state is CartItemDeleted) {
                              count = state.cart.items!.length;
                            }
                            if (state is CartLoaded) {
                              count = state.cart.items!.length;
                            }

                            if (count != null) {
                              return Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                  child: Text(
                                    count.toString(),
                                    style:
                                        kStyle12.copyWith(color: Colors.white),
                                  ));
                            }
                            return Container();
                          },
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}


// / CustomScrollView(
//           slivers: [
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               sliver: SliverToBoxAdapter(
                // child: SearchBar(
                //   focusNode: _node,
                // ),
//               ),
//             ),
//             _showSearch
//                 ? SearchOverlay()
//                 : SliverToBoxAdapter(
//                     child: Container(),
//                   )
//           ],
//         ),