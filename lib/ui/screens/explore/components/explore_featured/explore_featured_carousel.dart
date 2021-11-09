import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/multi_sliver/multi_sliver.dart';

class ExploreFeaturedCarousel extends StatelessWidget {
  const ExploreFeaturedCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiSliver(children: [
      SliverPadding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 16),
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
                  enableInfiniteScroll: false,
                  aspectRatio: 16 / 8,
                  viewportFraction: .9),
              items: List.filled(
                  5,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 4),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green,
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/background.png',
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ))),
        ),
      )
    ]);
  }
}
