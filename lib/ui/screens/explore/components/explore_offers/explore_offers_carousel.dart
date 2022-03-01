import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/blocs/offer_banners/offer_banners_bloc.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_offers/loading_widgets/explore_offers_loading.dart';
import 'package:themotorwash/ui/screens/offer_stores_list/offer_stores_list_screen.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreOffersCarousel extends StatefulWidget {
  final OfferBannersBloc bannersBloc;
  const ExploreOffersCarousel({Key? key, required this.bannersBloc})
      : super(key: key);

  @override
  State<ExploreOffersCarousel> createState() => _ExploreOffersCarouselState();
}

class _ExploreOffersCarouselState extends State<ExploreOffersCarousel> {
  late final GlobalLocationBloc _globalLocationBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.bannersBloc.add(GetOffersBanners());
    _globalLocationBloc =
        BlocProvider.of<GlobalLocationBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // return SliverToBoxAdapter(
    //   child: Text('hell'),
    // );
    String? cityCode;
    if (_globalLocationBloc.state is LocationSet) {
      cityCode = (_globalLocationBloc.state as LocationSet).location.cityCode;
    }
    return BlocBuilder<OfferBannersBloc, OfferBannersState>(
      bloc: widget.bannersBloc,
      builder: (context, state) {
        if (state is OfferBannersLoaded) {
          var offers = state.offers;
          return MultiSliver(children: [
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 8, bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Today\'s Offers',
                      style: SizeConfig.kStyle16Bold,
                    ),
                    Text(
                      'Give your pocket a treat',
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

                child: CarouselSlider(
                    options: CarouselOptions(
                        onPageChanged: (index, _) {
                          // setState(() {
                          //   carouselPageNumber = index + 1;
                          // });
                        },
                        // aspectRatio: 290 / 132,
                        // disableCenter: true,
                        height: ((132 / 290) * (85.w + 8)),
                        autoPlay: true,
                        autoPlayCurve: Curves.easeInOut,
                        enableInfiniteScroll: true,
                        viewportFraction: .85),
                    items: offers
                        .map((e) => GestureDetector(
                              onTap: () {
                                mixpanel?.track('Offer Banner Click',
                                    properties: {
                                      'url': e.bannerUrl.toString()
                                    });
                                Navigator.pushNamed(
                                    context, OfferStoresListScreen.route,
                                    arguments: OfferStoresListArguments(
                                        title: 'Stores',
                                        imageUrl: e.bannerUrl.toString()));
                              },
                              child: CachedNetworkImage(
                                imageUrl: e.bannerUrl!,
                                imageBuilder: (ctx, imageProvider) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.green,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                },
                                placeholder: (_, __) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      child: ShimmerPlaceholder(),
                                    ),
                                  );
                                },
                              ),
                            ))
                        .toList()),
              ),
            )
          ]);
        }
        // return SliverToBoxAdapter(
        //   child: Text('hell'),
        // );
        return ExploreOffersLoading();
      },
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
