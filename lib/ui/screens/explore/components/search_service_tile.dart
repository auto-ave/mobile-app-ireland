import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';

class SearchServiceTile extends StatelessWidget {
  final String serviceName;
  final String imageUrl;
  const SearchServiceTile(
      {Key? key, required this.imageUrl, required this.serviceName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, StoreListScreen.route,
            arguments: StoreListArguments(city: '462001', title: serviceName));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
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
              kverticalMargin8,
              Text(
                serviceName,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
