import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_detail/booking_detail.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';

class YourBookingTile extends StatefulWidget {
  final String storeName;
  final String address;
  final String total;
  final List<String> serviceNames;
  final String imageUrl;
  final DateTime bookedAt;
  final String bookingId;
  final BookingStatus status;
  const YourBookingTile({
    Key? key,
    required this.storeName,
    required this.address,
    required this.total,
    required this.serviceNames,
    required this.imageUrl,
    required this.bookedAt,
    required this.bookingId,
    required this.status,
  }) : super(key: key);

  @override
  _YourBookingTileState createState() => _YourBookingTileState();
}

class _YourBookingTileState extends State<YourBookingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 16,
                  color: Color.fromRGBO(0, 0, 0, 0.16))
            ]),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Hero(
                tag: widget.bookingId,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              kHorizontalMargin8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.storeName, style: kStyle16SemiBold),
                    Text(
                      widget.address,
                      style: kStyle12.copyWith(color: Color(0xff888888)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Text('₹${widget.total}', style: kStyle16SemiBold)
            ]),
            Divider(),
            getBookingStatusTag(widget.status),
            kverticalMargin8,
            Text(
              'I T E M S',
              style: kStyle12SemiBold.copyWith(color: Color(0xff888888)),
            ),
            kverticalMargin4,
            ...(widget.serviceNames.map((e) => getBulletText(e)).toList()),
            kverticalMargin4,
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, BookingDetailScreen.route,
                    arguments: BookingDetailScreenArguments(
                        bookingId: widget.bookingId, status: widget.status));
              },
              child: Text(
                'More Info',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            Divider(),
            kverticalMargin8,
            Text(
              'SCHEDULED ON',
              style: kStyle12SemiBold.copyWith(
                  letterSpacing: 2.16, color: Color(0xff888888)),
            ),
            kverticalMargin8,
            Text('24 Jun 2021 at 5:30pm'),
            kverticalMargin8,
            Row(
              children: <Widget>[
                getButton(
                    borderAndTextColor: Theme.of(context).primaryColor,
                    buttonText: 'Reschedule',
                    onPressed: () {}),
                Spacer(),
                getButton(
                    borderAndTextColor: Color(0xffDC1313),
                    buttonText: 'Cancel',
                    onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget getButton(
      {required String buttonText,
      required Color borderAndTextColor,
      required onPressed}) {
    return Expanded(
      // width: MediaQuery.of(context).size.width * .3,
      child: TextButton(
        onPressed: () {},
        child: Text(
          buttonText,
          style: TextStyle(color: borderAndTextColor),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              color: borderAndTextColor,
              width: 1,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  Widget getBulletText(String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [Text("\u2022 $text"), kverticalMargin4],
    );
  }
}

Widget getBookingStatusTag(BookingStatus status) {
  var colors = getBookingStatusTagColor(status);
  var text = getBookingStatusTagText(status);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    child: Text(
      text,
      style: kStyle14W500.copyWith(color: colors.textColor, letterSpacing: 1.2),
    ),
    decoration: BoxDecoration(
        color: colors.backgroundColor, borderRadius: BorderRadius.circular(2)),
  );
}

BookingStatusTagColors getBookingStatusTagColor(BookingStatus status) {
  final BookingStatusTagColors redShade = BookingStatusTagColors(
      textColor: Color(0xffE94235), backgroundColor: Color(0xffFFD6D6));
  final BookingStatusTagColors greenShade = BookingStatusTagColors(
      textColor: Color(0xff35B559), backgroundColor: Color(0xffD6FFE1));
  switch (status) {
    case BookingStatus.notPaid:
      return redShade;
    case BookingStatus.paymentDone:
      return greenShade;
    case BookingStatus.paymentFailed:
      return redShade;
    case BookingStatus.notAttended:
      return redShade;
    case BookingStatus.serviceStarted:
      return greenShade;
    case BookingStatus.serviceCompleted:
      return greenShade;
    default:
      return redShade;
  }
}

String getBookingStatusTagText(BookingStatus status) {
  switch (status) {
    case BookingStatus.notPaid:
      return 'NOT PAID';
    case BookingStatus.paymentDone:
      return 'PAYMENT DONE';
    case BookingStatus.paymentFailed:
      return 'PAYMENT FAILED';
    case BookingStatus.notAttended:
      return 'NOT ATTENDED';
    case BookingStatus.serviceStarted:
      return 'SERVICE STARTED';
    case BookingStatus.serviceCompleted:
      return 'COMPLETED';
    default:
      return 'STATUS UNAVAILABLE';
  }
}

class BookingStatusTagColors {
  final Color textColor;
  final Color backgroundColor;
  BookingStatusTagColors({
    required this.textColor,
    required this.backgroundColor,
  });
}
