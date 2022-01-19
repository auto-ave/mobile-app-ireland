import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/offer_banners/offer_banners_bloc.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/components/explore_featured/loading_widgets/explore_featured_loading.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreFeaturedCarousel extends StatefulWidget {
  final OfferBannersBloc bannersBloc;
  const ExploreFeaturedCarousel({Key? key, required this.bannersBloc})
      : super(key: key);

  @override
  State<ExploreFeaturedCarousel> createState() =>
      _ExploreFeaturedCarouselState();
}

class _ExploreFeaturedCarouselState extends State<ExploreFeaturedCarousel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.bannersBloc.add(GetOffersBanners());
  }

  @override
  Widget build(BuildContext context) {
    // return SliverToBoxAdapter(
    //   child: Text('hell'),
    // );
    return BlocBuilder<OfferBannersBloc, OfferBannersState>(
      bloc: widget.bannersBloc,
      builder: (context, state) {
        // return ExploreFeaturedLoading();
        if (state is OfferBannersLoaded) {
          var offers = state.offers;
          return MultiSliver(children: [
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 8, bottom: 16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Today’s Featured',
                  style: SizeConfig.kStyle16Bold,
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
                        .map((e) => CachedNetworkImage(
                              imageUrl: e.bannerUrl!,
                              imageBuilder: (ctx, imageProvider) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
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
                            ))
                        .toList()),
              ),
            )
          ]);
        }
        // return SliverToBoxAdapter(
        //   child: Text('hell'),
        // );
        return ExploreFeaturedLoading();
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