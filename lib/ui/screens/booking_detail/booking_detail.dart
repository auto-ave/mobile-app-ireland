// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themotorwash/blocs/booking_summary/bloc/booking_summary_bloc.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/your_bookings/components/your_bookings_tile.dart';
import 'package:themotorwash/ui/widgets/dashed_booking_box.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/utils.dart';

class BookingDetailScreen extends StatefulWidget {
  final BookingStatus status;
  final String bookingId;
  const BookingDetailScreen({
    Key? key,
    required this.status,
    required this.bookingId,
  }) : super(key: key);
  static final String route = '/bookingDetailScreen';
  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  late BookingSummaryBloc _bookingSummaryBloc;

  @override
  void initState() {
    super.initState();
    _bookingSummaryBloc = BookingSummaryBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _bookingSummaryBloc.add(GetBookingSummary(bookingId: widget.bookingId));
  }

  Review? _review;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithBackButton(context: context),
      body: BlocBuilder<BookingSummaryBloc, BookingSummaryState>(
        bloc: _bookingSummaryBloc,
        builder: (context, state) {
          if (state is BookingSummaryLoading) {
            return Center(
              child: loadingAnimation(),
            );
          }
          if (state is BookingSummaryLoaded) {
            var bookingDetail = state.booking;

            var reviewState = state.booking.review;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Order Details',
                      style: kStyle20W500,
                    ),
                    kverticalMargin16,
                    Row(children: <Widget>[
                      Hero(
                        tag: widget.bookingId,
                        child: CachedNetworkImage(
                          imageUrl: bookingDetail.store!.thumbnail!,
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
                            Text(bookingDetail.store!.name!,
                                style: kStyle16W500),
                            Text(
                              bookingDetail.store!.address!,
                              style:
                                  kStyle12.copyWith(color: Color(0xff888888)),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ]),
                    kverticalMargin16,
                    getBookingStatusTag(bookingDetail.status!),
                    kverticalMargin16,
                    bookingDetail.status == BookingStatus.paymentDone
                        ? SizedBox(
                            child: AddToCalendarButton(
                                bookingDetail: bookingDetail),
                            width: MediaQuery.of(context).size.width,
                          )
                        : Container(),
                    kverticalMargin16,
                    bookingDetail.status == BookingStatus.paymentDone
                        ? StoreContactWidget(
                            personToContact:
                                bookingDetail.store!.contactPersonName!,
                            phoneNumber:
                                bookingDetail.store!.contactPersonNumber!)
                        : Container(),
                    Text('Booking Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: kfontSize20)),
                    kverticalMargin8,
                    DashedBookingBox(bookingDetail: bookingDetail),
                    kverticalMargin16,
                    Divider(),
                    widget.status == BookingStatus.serviceCompleted
                        ? (_review != null || reviewState != null)
                            ? ReviewWidget(
                                rating: double.parse(
                                    getNotNullReview(_review, reviewState)!
                                        .rating!),
                                review: getNotNullReview(_review, reviewState)!
                                    .reviewDescription)
                            : RateServiceWidget(
                                bookingId: state.booking.bookingId!,
                                onReview: (review) {
                                  setState(() {
                                    _review = review;
                                  });
                                },
                                store: state.booking.store!,
                              )
                        : Container(),
                  ],
                ),
              ),
            );
          }
          if (state is BookingSummaryError) {
            return Center(
              child: ErrorScreen(
                ctaType: ErrorCTA.reload,
                onCTAPressed: () {
                  _bookingSummaryBloc
                      .add(GetBookingSummary(bookingId: widget.bookingId));
                },
              ),
            );
          }
          return Center(
            child: loadingAnimation(),
          );
        },
      ),
    );
  }

  Review? getNotNullReview(Review? review1, Review? review2) {
    if (review1 != null) {
      return review1;
    }
    return review2;
  }
}

class AddToCalendarButton extends StatelessWidget {
  final BookingDetailModel bookingDetail;
  const AddToCalendarButton({
    Key? key,
    required this.bookingDetail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        try {
          String description = '';

          bookingDetail.services!.forEach((element) {
            description = description + ', ' + element.service.toString();
          });
          // final Event event = Event(
          //   title: 'MotorWash booking for ${bookingDetail.vehicleType}',
          //   description: 'Services : ${description.substring(1)}',
          //   location: '${bookingDetail.store!.address}',
          //   startDate: bookingDetail.event!.startDateTime,
          //   endDate: bookingDetail.event!.endDateTime,
          // );
          // Add2Calendar.addEvent2Cal(event);
        } catch (e) {
          showSnackbar(context, 'No calendar app found');
        }
      },
      icon: Icon(Icons.calendar_today_outlined, color: Colors.white),
      label: Text(
        'Add to calendar',
        style: TextStyle(color: Colors.white),
      ),
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).primaryColor),
        elevation: MaterialStateProperty.all(4),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
