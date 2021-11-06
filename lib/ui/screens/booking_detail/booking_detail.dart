// import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themotorwash/blocs/booking_summary/bloc/booking_summary_bloc.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/feedback/feedback_screen.dart';
import 'package:themotorwash/ui/screens/your_bookings/components/your_bookings_tile.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/dashed_booking_box.dart';
import 'package:themotorwash/ui/widgets/directions_button.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
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
      appBar: getAppBarWithBackButton(context: context, actions: [
        CommonTextButton(
            onPressed: () {
              Navigator.pushNamed(context, FeedbackScreen.route,
                  arguments: FeedbackScreenArguments(
                      isFeedback: false, orderNumber: widget.bookingId));
            },
            child: Text(
              'Support',
              style: SizeConfig.kStyle16PrimaryColor,
            ),
            backgroundColor: Colors.white)
      ]),
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
                      style: SizeConfig.kStyle20W500,
                    ),
                    SizeConfig.kverticalMargin16,
                    Row(children: <Widget>[
                      Hero(
                        tag: widget.bookingId,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                      SizeConfig.kHorizontalMargin8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(bookingDetail.store!.name!,
                                style: SizeConfig.kStyle16W500),
                            Text(
                              bookingDetail.store!.address!,
                              style: SizeConfig.kStyle12
                                  .copyWith(color: Color(0xff888888)),
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
                    ]),
                    SizeConfig.kverticalMargin24,
                    getBookingStatusTag(bookingDetail.status!),
                    SizeConfig.kverticalMargin24,
                    bookingDetail.status == BookingStatus.paymentDone
                        ? SizedBox(
                            child: AddToCalendarButton(
                                bookingDetail: bookingDetail),
                            width: MediaQuery.of(context).size.width,
                          )
                        : Container(),
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
                            fontSize: SizeConfig.kfontSize20)),
                    SizeConfig.kverticalMargin8,
                    DashedBookingBox(bookingDetail: bookingDetail),
                    SizeConfig.kverticalMargin16,
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
          final Event event = Event(
            title:
                'MotorWash booking for ${bookingDetail.vehicleModel!.brand} ${bookingDetail.vehicleModel!.model}',
            description: 'Services : ${description.substring(1)}',
            location: '${bookingDetail.store!.address}',
            startDate: bookingDetail.event!.startDateTime,
            endDate: bookingDetail.event!.endDateTime,
          );
          Add2Calendar.addEvent2Cal(event);
        } catch (e) {
          showSnackbar(context, 'No calendar app found');
        }
      },
      icon: Icon(Icons.calendar_today_outlined, color: Colors.white),
      label: Text(
        'Add event to calendar',
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
