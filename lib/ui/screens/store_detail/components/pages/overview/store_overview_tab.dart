import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';

import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/overview/components/store_google_map.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/overview/components/store_heading.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/overview/components/store_info.dart';

class StoreOverviewTab extends StatefulWidget {
  final BuildContext nestedScrollContext;
  final String storeSlug;
  final Store store;
  final Function onPressedBook;
  final Function onPressedRating;
  const StoreOverviewTab({
    Key? key,
    required this.nestedScrollContext,
    required this.storeSlug,
    required this.store,
    required this.onPressedBook,
    required this.onPressedRating,
  }) : super(key: key);

  @override
  _StoreOverviewTabState createState() => _StoreOverviewTabState();
}

class _StoreOverviewTabState extends State<StoreOverviewTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () => widget.onPressedBook(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 4),
                    color: Color.fromRGBO(17, 17, 17, .32),
                    blurRadius: 32)
              ],
              gradient: LinearGradient(
                begin: Alignment(0.0, 0.0),
                end: Alignment(0.997, 0.082),
                // transform: GradientRotation(1.5708),
                colors: [
                  Theme.of(context).primaryColor,
                  Color(0xff298ED7),
                ],
              ),
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(56)),
          child: Text(
            'Book Service',
            style: kStyle16Bold.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverOverlapInjector(
            // This is the flip side of the SliverOverlapAbsorber
            // above.
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                widget.nestedScrollContext),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 8),
            sliver: SliverToBoxAdapter(
                child: StoreHeading(
              onPressedRating: widget.onPressedRating,
              name: widget.store.name!,
              numberOfRatings: widget.store.ratingCount!,
              rating: widget.store.rating,
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
                child: StoreInfo(
              address: widget.store.address!,
              // closingTime: store.storeClosingTime!,
              // openingTime: store.storeOpeningTime!,
              serviceStartsAt:
                  widget.store.servicesStart.toString(), //TODO : todo
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            sliver: SliverToBoxAdapter(
                child: Text(
              'About',
              style: kStyle20W500,
            )),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            sliver: SliverToBoxAdapter(
                child: Text(
              widget.store.description!,
              style: kStyle12,
            )),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            sliver: SliverToBoxAdapter(
                child: StoreGoogleMap(
              storeTitle: widget.store.name!,
              latitute: widget.store.latitude!,
              longitute: widget.store.longitude!,
            )
                //      StoreMap(
                // latitute: widget.store.latitude!,
                // longitute: widget.store.longitude!,
                // )
                ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            sliver: SliverToBoxAdapter(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(1),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () async {
                      final availableMaps = await MapLauncher.installedMaps;
                      print(
                          availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                      await availableMaps.first.showDirections(
                          destination: Coords(
                              widget.store.latitude!, widget.store.longitude!));
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/map.svg',
                      width: 24,
                    ),
                    label: Text(
                      'Open in maps',
                      style: kStyle16.copyWith(color: Colors.black),
                    )),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
