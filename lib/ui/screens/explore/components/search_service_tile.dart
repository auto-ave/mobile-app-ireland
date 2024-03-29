import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/data/analytics/analytics_events.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';

class SearchServiceTile extends StatelessWidget {
  final String serviceName;
  final String imageUrl;
  final String serviceTag;
  final String bannerUrl;
  const SearchServiceTile(
      {Key? key,
      required this.imageUrl,
      required this.serviceName,
      required this.serviceTag,
      required this.bannerUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // mixpanel?.track(SearchServiceClick().eventName(), properties: {
        //   'service_name': serviceName,
        //   'service_tag': serviceTag
        // });
        Navigator.pushNamed(context, StoreListScreen.route,
            arguments: StoreListArguments(
                city: 'bpl',
                title: serviceName,
                serviceTag: serviceTag,
                imageUrl: bannerUrl));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          width: 120,
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  imageUrl: imageUrl,
                ),
              ),
              SizeConfig.kverticalMargin8,
              Text(
                serviceName,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
