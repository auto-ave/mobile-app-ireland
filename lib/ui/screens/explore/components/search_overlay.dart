import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:themotorwash/blocs/search_services/search_services_bloc.dart';
import 'package:themotorwash/blocs/search_stores/search_stores_bloc.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/search_service_tile.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    // return SliverToBoxAdapter(child: Text('hello'));
    return LazyLoadScrollView(
      onEndOfPage: _loadMoreStores,
      child: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Services',
              style: SizeConfig.kStyle14W500
                  .copyWith(color: SizeConfig.kPrimaryColor),
            ),
          ),
        ),
        BlocBuilder<SearchServicesBloc, SearchServicesState>(
          bloc: widget.searchServicesBloc,
          builder: (context, state) {
            if (state is LoadingSearchServicesResult) {
              return SliverToBoxAdapter(child: ScrollableServiceLoading());
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
                            children: <Widget>[SizeConfig.kHorizontalMargin16] +
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
                        child: Center(
                            child:
                                Text('No services with the given query found')),
                        width: double.infinity,
                        height: 100,
                      ),
              );
            }
            if (state is SearchedServicesError) {}
            return SliverToBoxAdapter(child: ScrollableServiceLoading());
          },
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverToBoxAdapter(
              child: Text(
            'Stores',
            style: SizeConfig.kStyle14W500
                .copyWith(color: SizeConfig.kPrimaryColor),
          )),
        ),
        BlocBuilder<SearchStoresBloc, SearchStoresState>(
          bloc: widget.searchStoresBloc,
          builder: (context, state) {
            if (state is LoadingSearchStoresResult) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  List.filled(4, StoreSearchLoadingTile()),
                ),
              );
            }
            if (state is SearchedStoresResult) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                (_, index) {
                  var store = state.searchedStores[index];
                  return StoreSearchTile(
                      isNew: store.rating == null,
                      distance: store.distance ?? 'dis',
                      imageURL: store.thumbnail ?? 'thumb',
                      rating: store.rating,
                      storeName: store.name,
                      startingFrom: store.servicesStart ?? 'serviceStarts',
                      storeSlug: store.storeSlug ?? 'store-slug');
                },
                childCount: state.searchedStores.length,
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
