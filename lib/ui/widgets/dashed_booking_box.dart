import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/utils/utils.dart';

class DashedBookingBox extends StatelessWidget {
  final BookingDetailModel bookingDetail;
  final Color? backgroundColor;
  DashedBookingBox(
      {Key? key, required this.bookingDetail, this.backgroundColor})
      : super(key: key);
  final TextStyle rightSideInfoPrimaryColor = TextStyle(
      color: SizeConfig.kPrimaryColor,
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.kfontSize12);
  final TextStyle leftSideInfo =
      TextStyle(fontWeight: FontWeight.w400, fontSize: SizeConfig.kfontSize12);
  final TextStyle leftSide14W500 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize14);
  final TextStyle rightSide12W500 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize12);
  final DateFormat formatter = DateFormat('MMM d hh:mm a');

  final DateFormat formatterTime = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [8, 4],
      color: Theme.of(context).primaryColor,
      borderType: BorderType.Rect,
      child: Container(
        decoration: BoxDecoration(color: backgroundColor ?? Color(0xffF3F8FF)),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            bookingDetail.status == BookingStatus.paymentSuccess
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DetailsRowWidget(
                          leftText: 'OTP',
                          rightText: bookingDetail.otp ?? 'N/A',
                          leftStyle: leftSideInfo,
                          rightStyle: rightSideInfoPrimaryColor),
                      SizeConfig.kverticalMargin8,
                    ],
                  )
                : SizedBox.shrink(),
            DetailsRowWidget(
                leftText: 'Booking Id',
                rightText: bookingDetail.bookingId!,
                leftStyle: leftSideInfo,
                rightStyle: rightSideInfoPrimaryColor),
            SizeConfig.kverticalMargin8,
            DetailsRowWidget(
                leftText: 'Car Model:',
                rightText:
                    '${bookingDetail.vehicleModel!.brand} ${bookingDetail.vehicleModel!.model}',
                leftStyle: leftSideInfo,
                rightStyle: rightSideInfoPrimaryColor),
            SizeConfig.kverticalMargin8,
            bookingDetail.isMultiDay
                ? DetailsRowWidget(
                    leftText: 'Vehicle Drop Off Time:',
                    rightText:
                        formatter.format(bookingDetail.event!.startDateTime),
                    leftStyle: leftSideInfo,
                    rightStyle: rightSideInfoPrimaryColor)
                : DetailsRowWidget(
                    leftText: 'Scheduled on',
                    rightText:
                        formatter.format(bookingDetail.event!.startDateTime),
                    leftStyle: leftSideInfo,
                    rightStyle: rightSideInfoPrimaryColor),
            SizeConfig.kverticalMargin8,
            Divider(),
            SizeConfig.kverticalMargin8,
            bookingDetail.isMultiDay
                ? DetailsRowWidget(
                    leftText: 'Estimated Completion Date:',
                    rightText:
                        '${formatter.format(bookingDetail.event!.endDateTime)}',
                    leftStyle: leftSideInfo,
                    rightStyle: rightSideInfoPrimaryColor)
                : DetailsRowWidget(
                    leftText: 'Time:',
                    rightText:
                        '${formatterTime.format(bookingDetail.event!.startDateTime)} to ${formatterTime.format(bookingDetail.event!.endDateTime)}',
                    leftStyle: leftSideInfo,
                    rightStyle: rightSideInfoPrimaryColor),
            SizeConfig.kverticalMargin8,
            ...(bookingDetail.services!
                .map((e) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DetailsRowWidget(
                            leftText: e.service,
                            rightText: '${e.price}'.euro(),
                            leftStyle: leftSide14W500,
                            rightStyle: rightSide12W500),
                        SizeConfig.kverticalMargin8
                      ],
                    ))
                .toList()),
            SizeConfig.kverticalMargin8,
            DetailsRowWidget(
              leftText: 'Total amount',
              rightText: '${bookingDetail.amount}'.euro(),
              leftStyle:
                  SizeConfig.kStyle14.copyWith(fontWeight: FontWeight.w600),
              rightStyle: TextStyle(
                  color: SizeConfig.kPrimaryColor,
                  fontSize: SizeConfig.kfontSize16,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  // Widget getDetailsRow(
  //     {required String leftText,
  //     required String rightText,
  //     required TextStyle leftStyle,
  //     required TextStyle rightStyle}) {
  //   return Row(
  //     children: <Widget>[
  //       Text(
  //         leftText,
  //         style: leftStyle,
  //       ),
  //       Spacer(),
  //       Text(rightText, style: rightStyle),
  //     ],
  //   );
  // }
}
