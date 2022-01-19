import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';

class ExploreServiceTile extends StatelessWidget {
  final String serviceName;
  final String imageUrl;
  final String serviceTag;
  const ExploreServiceTile(
      {Key? key,
      required this.imageUrl,
      required this.serviceName,
      required this.serviceTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, StoreListScreen.route,
            arguments: StoreListArguments(
                city: 'bpl', title: serviceName, serviceTag: serviceTag));
      },
      child: SizedBox(
        width: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                placeholder: (_, __) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(86.0)),
                    ),
                    child: ShimmerPlaceholder(),
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.hardEdge,
                  );
                },
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(86.0),
                      ),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 16,
                            offset: Offset(0, 2),
                            color: Color.fromRGBO(0, 0, 0, 0.25))
                      ]),
                ),
              ),
              // Container(
              //   clipBehavior: Clip.hardEdge,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(4),
              // boxShadow: [
              //   BoxShadow(blurRadius: 16, offset: Offset(0, 2))
              // ]),
              //   child: CachedNetworkImage(
              //     fit: BoxFit.cover,
              //     width: 100,
              //     height: 100,
              //     imageUrl: imageUrl,
              //   ),
              // ),
              SizeConfig.kverticalMargin8,
              Flexible(
                child: Text(
                  serviceName,
                  style: SizeConfig.kStyle12W500
                      .copyWith(color: SizeConfig.kGreyTextColor),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
