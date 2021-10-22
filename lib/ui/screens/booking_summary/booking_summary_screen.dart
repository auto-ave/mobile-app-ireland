import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:themotorwash/blocs/booking_summary/bloc/booking_summary_bloc.dart';
import 'package:themotorwash/blocs/review/review_bloc.dart';
import 'package:themotorwash/data/models/booking_detail.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_detail/booking_detail.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/dashed_booking_box.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/utils.dart';

class BookingSummaryScreen extends StatefulWidget {
  final bool isTransactionSuccessful;
  BookingSummaryScreen(
      {Key? key,
      required this.bookingId,
      required this.isTransactionSuccessful})
      : super(key: key);
  static final String route = "/bookingSummaryScreen";
  final String bookingId;

  @override
  _BookingSummaryScreenState createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  // final TextStyle rightSideInfoPrimaryColor = TextStyle(
  //     color: SizeConfig.kPrimaryColor, fontWeight: FontWeight.w400, fontSize: SizeConfig.kfontSize12);
  // final TextStyle leftSideInfo =
  //     const TextStyle(fontWeight: FontWeight.w400, fontSize: SizeConfig.kfontSize12);
  // final TextStyle leftSide14W500 =
  //     TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize14);
  // final TextStyle rightSide12W500 =
  //     TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize12);

  late BookingSummaryBloc _bookingSummaryBloc;

  Review? _review;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookingSummaryBloc = BookingSummaryBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _bookingSummaryBloc.add(GetBookingSummary(bookingId: widget.bookingId));
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY);

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, ExploreScreen.route, (route) => false);
        return false;
      },
      child: Scaffold(
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
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: <Widget>[
                            Image.asset(widget.isTransactionSuccessful
                                ? 'assets/images/bookingConfirmedHands.png'
                                : 'assets/images/thumbs_down.png'),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.isTransactionSuccessful
                                        ? 'Booking Confirmed'
                                        : 'Booking Failed',
                                    style: TextStyle(
                                        color: widget.isTransactionSuccessful
                                            ? Theme.of(context).primaryColor
                                            : Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: SizeConfig.kfontSize20),
                                  ),
                                  Text(
                                      widget.isTransactionSuccessful
                                          ? 'We have sent a receipt on your number and email'
                                          : 'There was an error processing the payment. Any amount deducted will be refunded in 3-5 business days. Your order isn’t booked.',
                                      style: TextStyle(
                                          fontSize: SizeConfig.kfontSize12)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        SizedBox(
                          child: bookingDetail.status ==
                                  BookingStatus.paymentDone
                              ? AddToCalendarButton(
                                  bookingDetail: bookingDetail)
                              : CommonTextButton(
                                  onPressed: () =>
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          ExploreScreen.route,
                                          (route) => false),
                                  child: Text(
                                    'Back to home',
                                    style: SizeConfig.kStyle16W500
                                        .copyWith(color: Colors.white),
                                  ),
                                  backgroundColor: SizeConfig.kPrimaryColor),
                          width: MediaQuery.of(context).size.width,
                        ),
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
                      ],
                    ),
                  ),
                ),
              );
            }
            if (state is BookingSummaryError) {
              return Center(
                child: ErrorScreen(
                  ctaType: ErrorCTA.home,
                  // onCTAPressed: () {
                  //   _bookingSummaryBloc
                  //       .add(GetBookingSummary(bookingId: widget.bookingId));
                  // },
                ),
              );
            }
            return Center(
              child: loadingAnimation(),
            );
          },
        ),
      ),
    );
  }
}

class StoreContactWidget extends StatelessWidget {
  final String personToContact;
  final String phoneNumber;
  const StoreContactWidget({
    Key? key,
    required this.personToContact,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          height: 16,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Person to contact: ',
              style: SizeConfig.kStyle14.copyWith(
                color: Colors.black,
              )),
          TextSpan(
              text: personToContact,
              style: SizeConfig.kStyle16Bold
                  .copyWith(color: SizeConfig.kPrimaryColor))
        ])),
        SizeConfig.kverticalMargin4,
        Text.rich(TextSpan(children: [
          TextSpan(
              text: 'Contact number: ',
              style: SizeConfig.kStyle14.copyWith(color: Colors.black)),
          TextSpan(
              text: phoneNumber,
              style: SizeConfig.kStyle16Bold
                  .copyWith(color: SizeConfig.kPrimaryColor))
        ])),
        Divider(
          height: 16,
        ),
      ],
    );
  }
}

class RateServiceWidget extends StatefulWidget {
  final Function(Review review) onReview;
  final String bookingId;
  final Store store;
  const RateServiceWidget({
    Key? key,
    required this.onReview,
    required this.bookingId,
    required this.store,
  }) : super(key: key);

  @override
  _RateServiceWidgetState createState() => _RateServiceWidgetState();
}

class _RateServiceWidgetState extends State<RateServiceWidget> {
  late ReviewBloc _reviewBloc;

  @override
  void initState() {
    super.initState();
    _reviewBloc =
        ReviewBloc(repository: RepositoryProvider.of<Repository>(context));
  }

  double _rating = 0;

  TextEditingController reviewDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewBloc, ReviewState>(
      bloc: _reviewBloc,
      listener: (context, state) {
        if (state is FailedToAddReview) {
          showSnackbar(context, 'Failed to add review. Something went wrong.');
        }
        if (state is ReviewAdded) {
          widget.onReview(state.review);
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Rate Service',
              style: SizeConfig.kStyle20W500,
            ),
            SizeConfig.kverticalMargin8,
            RatingBar(
              itemSize: 24,
              initialRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              ratingWidget: RatingWidget(
                half: Container(),
                full: SvgPicture.asset(
                  'assets/icons/rating_star_filled.svg',
                ),
                empty: SvgPicture.asset(
                  'assets/icons/rating_star_raw.svg',
                ),
              ),
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                _rating = rating;
              },
            ),
            SizeConfig.kverticalMargin8,
            Text(
              'Add a review',
              style: SizeConfig.kStyle16,
            ),
            SizeConfig.kverticalMargin8,
            Container(
              height: MediaQuery.of(context).size.height * .2,
              child: TextField(
                controller: reviewDescriptionController,
                style: TextStyle(fontSize: 18),
                maxLines: 100,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: SizeConfig.kPrimaryColor)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:
                            BorderSide(color: SizeConfig.kPrimaryColor)),
                    hintText: "Write a review"),
              ),
            ),
            CommonTextButton(
                onPressed: () {
                  if (_rating == 0) {
                    showSnackbar(context, 'Please rate from 1-5 stars');
                  } else {
                    bool isOnlyRating =
                        reviewDescriptionController.text.trim() == "";
                    _reviewBloc.add(
                      AddReview(
                        review: ReviewEntity(
                          bookingId: widget.bookingId,
                          isOnlyRating: isOnlyRating,
                          store: widget.store.id,
                          reviewDescription: reviewDescriptionController.text,
                          rating: _rating.toString(),
                        ),
                      ),
                    );
                  }
                },
                child: state is AddingReview
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text('Post', style: TextStyle(color: Colors.white)),
                backgroundColor: Theme.of(context).primaryColor),
          ],
        );
      },
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final double rating;
  final String? review;
  const ReviewWidget({
    Key? key,
    required this.rating,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Review',
          style: SizeConfig.kStyle20W500,
        ),
        SizeConfig.kverticalMargin8,
        RatingBar(
          itemSize: 24,
          initialRating: rating,
          ignoreGestures: true,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          ratingWidget: RatingWidget(
            half: Container(),
            full: SvgPicture.asset(
              'assets/icons/rating_star_filled.svg',
            ),
            empty: SvgPicture.asset(
              'assets/icons/rating_star_raw.svg',
            ),
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        SizeConfig.kverticalMargin16,
        Text(
          review ?? "",
          style: SizeConfig.kStyle12,
        )
      ],
    );
  }
}
