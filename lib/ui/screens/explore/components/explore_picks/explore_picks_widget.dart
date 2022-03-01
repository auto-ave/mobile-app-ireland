import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/featured_stores/bloc/featured_stores_bloc.dart';
import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/blocs/offer_banners/offer_banners_bloc.dart';
import 'package:themotorwash/data/analytics/analytics_events.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_picks/loading_widgets/explore_picks_loading.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExplorePicksWidget extends StatefulWidget {
  // final OfferBannersBloc bannersBloc;
  final FeaturedStoresBloc featuredStoresBloc;
  const ExplorePicksWidget({
    Key? key,
    required this.featuredStoresBloc,
  }) : super(key: key);

  @override
  State<ExplorePicksWidget> createState() => _ExplorePicksWidgetState();
}

class _ExplorePicksWidgetState extends State<ExplorePicksWidget> {
  late final GlobalLocationBloc _globalLocationBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return SliverToBoxAdapter(
    //   child: Text('hell'),
    // );
    // String? cityCode;
    // if (_globalLocationBloc.state is LocationSet) {
    //   cityCode = (_globalLocationBloc.state as LocationSet).location.cityCode;
    // }
    return BlocBuilder<FeaturedStoresBloc, FeaturedStoresState>(
      bloc: widget.featuredStoresBloc,
      builder: (context, state) {
        // return ExploreFeaturedLoading();
        if (state is FeaturedStoresLoaded) {
          var stores = state.stores;
          return MultiSliver(children: [
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Featured Stores',
                      style: SizeConfig.kStyle16Bold,
                    ),
                    Text(
                      'Hand picked autoave stores',
                      style: SizeConfig.kStyle10
                          .copyWith(color: SizeConfig.kGreyTextColor),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                // color: Colors.amber,

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                      //  Padding(
                      //   padding:
                      //    const EdgeInsets.symmetric(vertical: 8),
                      //   child:
                      Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[SizeConfig.kHorizontalMargin16] +
                        stores
                            .map((e) => PicksCardTile(
                                imageURL: e.thumbnail ?? '',
                                storeName: e.name,
                                distance: e.distance ?? '',
                                rating: e.rating,
                                startingFrom: e.servicesStart ?? '',
                                storeSlug: e.storeSlug ?? '',
                                address: e.address ?? ''))
                            .toList(),
                  ),
                  // ),
                ),
              ),
            )
          ]);
        }
        return ExplorePicksLoading();
        // return SliverToBoxAdapter(
        //   child: Text('hell'),
        // );
        // return ExploreFeaturedLoading();
      },
    );
  }
}

class PicksCardTile extends StatelessWidget {
  final String imageURL;
  final String storeName;
  final String distance;
  final String? rating;
  final String startingFrom;
  final String storeSlug;
  final String address;
  const PicksCardTile({
    Key? key,
    required this.imageURL,
    required this.storeName,
    required this.distance,
    required this.rating,
    required this.startingFrom,
    required this.storeSlug,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        mixpanel?.track(SearchStoreClick().eventName());
        Navigator.pushNamed(context, StoreDetailScreen.route,
            arguments: StoreDetailArguments(storeSlug: storeSlug));
      },
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Container(
            width: 50.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  color: Color.fromRGBO(0, 0, 0, .25))
            ], borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      placeholder: (_, __) {
                        return ShimmerPlaceholder();
                      },
                      height: 40.w,
                      imageUrl: imageURL,
                      // width: 100.w,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4, vertical: 4),
                            child: Text(
                              'Featured',
                              style: SizeConfig.kStyle12W500
                                  .copyWith(color: SizeConfig.kPrimaryColor),
                            ),
                            alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4)),
                                color: Colors.white)),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        storeName,
                        style: SizeConfig.kStyle14W500,
                      ),
                      SizeConfig.kverticalMargin4,
                      Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: SizeConfig.kStyle12
                            .copyWith(color: Color(0xff696969)),
                      ),
                      SizeConfig.kverticalMargin4,
                      Divider(
                        thickness: 1,
                        height: 8,
                      ),
                      Row(
                        children: [
                          rating != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    Text(
                                      rating!,
                                      style: SizeConfig.kStyle12.copyWith(
                                          color: SizeConfig.kGreyTextColor),
                                    ),
                                    SizeConfig.kHorizontalMargin4,
                                    Text(
                                      "•",
                                      style: SizeConfig.kStyle12.copyWith(
                                          color: SizeConfig.kGreyTextColor),
                                    ),
                                    SizeConfig.kHorizontalMargin4,
                                  ],
                                )
                              : Container(),
                          Text(
                            'Starts from ₹$startingFrom',
                            style: SizeConfig.kStyle12
                                .copyWith(color: SizeConfig.kGreyTextColor),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
// Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.green,
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                       'assets/images/background.png',
//                                     ),
//                                     fit: BoxFit.cover)),
//                           ),
