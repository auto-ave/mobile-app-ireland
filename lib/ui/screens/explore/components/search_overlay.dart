import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:themotorwash/blocs/search_services/search_services_bloc.dart';
import 'package:themotorwash/blocs/search_stores/search_stores_bloc.dart';
import 'package:themotorwash/data/analytics/analytics_events.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/search_service_tile.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/scrollable_service_loading.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/service_search_loading_tile.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/store_search_loading_tile.dart';
import 'package:themotorwash/ui/widgets/store_search_tile.dart';

class SearchOverlay extends StatefulWidget {
  final SearchServicesBloc searchServicesBloc;
  final SearchStoresBloc searchStoresBloc;
  final TextEditingController textController;
  const SearchOverlay({
    Key? key,
    required this.searchServicesBloc,
    required this.searchStoresBloc,
    required this.textController,
  }) : super(key: key);

  @override
  _SearchOverlayState createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  List<StoreListModel> stores = [];
  @override
  void initState() {
    super.initState();
    // mixpanel?.track(SearchClick().eventName());
    // widget.searchServicesBloc.stream.listen((state) {
    //   if (state is SearchedServicesResult && mounted) {
    //     setState(() {
    //       servicesEmpty = state.searchedServices.isEmpty;
    //     });
    //   }
    //   if (state is LoadingSearchServicesResult && mounted) {
    //     setState(() {
    //       servicesEmpty = false;
    //     });
    //   }
    // });
    // widget.searchStoresBloc.stream.listen((state) {
    //   if (state is SearchedStoresResult && mounted) {
    //     setState(() {
    //       storesEmpty = stores.isEmpty ? true : false;
    //     });
    //   }
    // });
  }

  bool servicesEmpty = false;
  bool storesEmpty = false;

  @override
  Widget build(BuildContext context) {
    // return SliverToBoxAdapter(child: Text('hello'));
    return
        // servicesEmpty && storesEmpty
        //     ? Center(
        //         child: Padding(
        //           padding: const EdgeInsets.all(20.0),
        //           child: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Image.asset('assets/images/no_results.png'),
        //               SizeConfig.kverticalMargin4,
        //               Text(
        //                 ' No results for ${widget.textController.text}.\nPlease check your search query',
        //                 style: SizeConfig.kStyle16.copyWith(
        //                   color: SizeConfig.kGreyTextColor,
        //                 ),
        //                 textAlign: TextAlign.center,
        //               )
        //             ],
        //           ),
        //         ),
        //       )
        //     :
        BlocBuilder<SearchStoresBloc, SearchStoresState>(
      bloc: widget.searchStoresBloc,
      builder: (context, storeState) {
        return BlocBuilder<SearchServicesBloc, SearchServicesState>(
          bloc: widget.searchServicesBloc,
          builder: (context, servicesState) {
            if (storeState is SearchedStoresResult &&
                servicesState is SearchedServicesResult) {
              stores = storeState.searchedStores;
              if (stores.isEmpty && servicesState.searchedServices.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/no_results.png'),
                        SizeConfig.kverticalMargin8,
                        Text(
                          ' No results for ${widget.textController.text}.\nPlease check your search query',
                          style: SizeConfig.kStyle16.copyWith(
                            color: SizeConfig.kGreyTextColor,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                );
              }
            }
            return LazyLoadScrollView(
              onEndOfPage: _loadMoreStores,
              child: CustomScrollView(slivers: [
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   sliver: SliverToBoxAdapter(
                //     child: Text(
                //       'Services',
                //       style: SizeConfig.kStyle14W500
                //           .copyWith(color: SizeConfig.kPrimaryColor),
                //     ),
                //   ),
                // ),
                BlocBuilder<SearchServicesBloc, SearchServicesState>(
                  bloc: widget.searchServicesBloc,
                  builder: (context, state) {
                    if (state is LoadingSearchServicesResult) {
                      return SliverToBoxAdapter(
                          child: ScrollableServiceLoading(
                        showTitle: true,
                      ));
                    }
                    if (state is SearchedServicesResult) {
                      return SliverToBoxAdapter(
                        child: state.searchedServices.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    child: Text(
                                      'Services',
                                      style: SizeConfig.kStyle14W500.copyWith(
                                          color: SizeConfig.kPrimaryColor),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child:
                                        //  Padding(
                                        //   padding:
                                        //    const EdgeInsets.symmetric(vertical: 8),
                                        //   child:
                                        Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                            SizeConfig.kHorizontalMargin16
                                          ] +
                                          state.searchedServices
                                              .map((e) => SearchServiceTile(
                                                    imageUrl: e.thumbnail!,
                                                    serviceName: e.name!,
                                                    serviceTag: e.slug!,
                                                    bannerUrl: e.bannerUrl ??
                                                        SizeConfig
                                                            .autoaveBanner,
                                                  ))
                                              .toList(),
                                    ),
                                    // ),
                                  ),
                                ],
                              )
                            : SizedBox.shrink(),
                      );
                    }
                    if (state is SearchedServicesError) {}
                    return SliverToBoxAdapter(
                        child: ScrollableServiceLoading(
                      showTitle: true,
                    ));
                  },
                ),
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                      child: Text(
                    'Stores',
                    style: SizeConfig.kStyle14W500
                        .copyWith(color: SizeConfig.kPrimaryColor),
                  )),
                ),
                BlocConsumer<SearchStoresBloc, SearchStoresState>(
                  bloc: widget.searchStoresBloc,
                  listener: (_, state) {
                    setState(
                        () {}); //TODO Find alternative for this workaround (Need setState for lazyloading to trigger)
                  },
                  builder: (context, state) {
                    if (state is LoadingSearchStoresResult) {
                      return SliverList(
                        delegate: SliverChildListDelegate(
                          List.filled(4, StoreSearchLoadingTile()),
                        ),
                      );
                    }
                    if (state is SearchedStoresResult ||
                        state is LoadingMoreSearchStoresResult) {
                      if (state is SearchedStoresResult) {
                        stores = state.searchedStores;
                      }
                      return stores.isEmpty
                          ? SliverFillRemaining(
                              child: Center(
                              child:
                                  Image.asset('assets/images/no_results.png'),
                            ))
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                              (_, index) {
                                final store = stores[index];
                                var tile = StoreSearchTile(
                                    isNew: store.rating == null,
                                    distance: store.distance ?? 'dis',
                                    imageURL: store.thumbnail ?? 'thumb',
                                    rating: store.rating,
                                    storeName: store.name,
                                    startingFrom: store.servicesStart ?? '',
                                    storeSlug: store.storeSlug ?? 'store-slug');
                                if (state is LoadingMoreSearchStoresResult &&
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
                        List.filled(3, StoreSearchLoadingTile()),
                      ),
                    );
                  },
                )
              ]),
            );
          },
        );
      },
    );
  }

  void _loadMoreStores() {
    var currentState = widget.searchStoresBloc.state;
    if (!widget.searchStoresBloc.hasReachedMax(currentState, true)) {
      if (currentState is SearchedStoresResult) {
        widget.searchStoresBloc.add(SearchStores(
            query: widget.textController.text,
            forLoadMore: true,
            offset: stores.length));
      }
    }
  }
}
