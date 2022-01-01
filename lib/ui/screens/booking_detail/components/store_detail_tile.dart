import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/directions_button.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';

class StoreDetailTile extends StatelessWidget {
  final BookingDetailModel bookingDetail;
  const StoreDetailTile({Key? key, required this.bookingDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Hero(
        tag: bookingDetail.bookingId!,
        child: CachedNetworkImage(
          placeholder: (_, __) {
            return Container(
              child: ShimmerPlaceholder(),
              width: 50,
              height: 50,
            );
          },
          imageUrl: bookingDetail.store!.thumbnail!,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      SizeConfig.kHorizontalMargin8,
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(bookingDetail.store!.name!, style: SizeConfig.kStyle16W500),
            Text(
              bookingDetail.store!.address!,
              style: SizeConfig.kStyle12.copyWith(color: Color(0xff888888)),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: DirectionsButton(
            latitude: bookingDetail.store!.latitude!,
            longitude: bookingDetail.store!.longitude!),
      )
    ]);
  }
}
