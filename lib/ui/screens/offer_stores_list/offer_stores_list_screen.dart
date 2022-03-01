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

class OfferStoresListScreen extends StatefulWidget {
  final String title;
  final String imageUrl;
  const OfferStoresListScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);
  static final String route = "/offerStoresList";
  @override
  _OfferStoresListScreenState createState() {
    FlutterUxcam.tagScreenName(route);
    return _OfferStoresListScreenState();
  }
}

class _OfferStoresListScreenState extends State<OfferStoresListScreen> {
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
    return Scaffold(
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
              // expandedHeight:
              //     100.w * 9 / 16 - SizeConfig.mediaQueryData.padding.top,
              expandedHeight: ((132 / 290) * (85.w + 8)),
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
                            autoaveLog(store.toString());
                            // var tile = StoreListTile(
                            //   isNew: 'tore.rating' == null,
                            //   distance: 'store.distance' ?? '',
                            //   imageURL: SizeConfig.autoaveBanner,
                            //   rating: 'store.rating' ?? 'unrated',
                            //   storeName: ' store.name',
                            //   startingFrom: 'store.servicesStart' ?? '',
                            //   storeSlug: ' store.storeSlug ' ?? 'automax',
                            //   taggedServices: null,
                            //   address: 'store.addres' ?? "",
                            // );
                            var tile = StoreListTile(
                              isNew: store.rating == null,
                              distance: store.distance ?? '',
                              imageURL: store.thumbnail ?? '',
                              rating: store.rating ?? 'unrated',
                              storeName: store.name,
                              startingFrom: store.servicesStart ?? '',
                              storeSlug: store.storeSlug ?? 'automax',
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
        _storeListBloc
            .add(LoadNearbyStoreList(offset: stores.length, forLoadMore: true));
      }
    }
  }
}
