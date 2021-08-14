import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themotorwash/blocs/booking_summary/bloc/booking_summary_bloc.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';

class BookingSummaryScreen extends StatefulWidget {
  BookingSummaryScreen({Key? key, required this.bookingId}) : super(key: key);
  static final String route = "/bookingSummaryScreen";
  final String bookingId;

  @override
  _BookingSummaryScreenState createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  late final TextStyle rightSideInfoPrimaryColor;

  late final TextStyle leftSideInfo;

  late final TextStyle leftSide14SemiBold;

  late final TextStyle rightSide12SemiBold;

  SizedBox verticalMargin8 = SizedBox(
    height: 8,
  );

  SizedBox verticalMargin16 = SizedBox(
    height: 16,
  );

  SizedBox verticalMargin32 = SizedBox(
    height: 32,
  );
  late BookingSummaryBloc _bookingSummaryBloc;
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
    rightSideInfoPrimaryColor = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w400,
        fontSize: kfontSize12);
    leftSideInfo =
        const TextStyle(fontWeight: FontWeight.w400, fontSize: kfontSize12);
    leftSide14SemiBold =
        TextStyle(fontWeight: FontWeight.w600, fontSize: kfontSize14);
    rightSide12SemiBold =
        TextStyle(fontWeight: FontWeight.w600, fontSize: kfontSize12);

    return Scaffold(
      body: BlocBuilder<BookingSummaryBloc, BookingSummaryState>(
        bloc: _bookingSummaryBloc,
        builder: (context, state) {
          if (state is BookingSummaryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BookingSummaryLoaded) {
            var bookingDetail = state.booking;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: <Widget>[
                        Image.asset('assets/images/bookingConfirmedHands.png'),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Booking Confirmed',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: kfontSize20),
                              ),
                              Text(
                                  'We have sent a receipt on your number and email',
                                  style: TextStyle(fontSize: kfontSize12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Text('Booking Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: kfontSize20)),
                    verticalMargin8,
                    DottedBorder(
                      dashPattern: [8, 4],
                      color: Theme.of(context).primaryColor,
                      borderType: BorderType.Rect,
                      child: Container(
                        decoration: BoxDecoration(color: Color(0xffF3F8FF)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            getDetailsRow(
                                leftText: 'Booking Id',
                                rightText: bookingDetail.bookingId!,
                                leftStyle: leftSideInfo,
                                rightStyle: rightSideInfoPrimaryColor),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Car Model:',
                                rightText: 'BMW X4',
                                leftStyle: leftSideInfo,
                                rightStyle: rightSideInfoPrimaryColor),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Scheduled on',
                                rightText:
                                    formatter.format(bookingDetail.createdAt!),
                                leftStyle: leftSideInfo,
                                rightStyle: rightSideInfoPrimaryColor),
                            verticalMargin8,
                            Divider(),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Time:',
                                rightText: '5:30pm to 6:30pm',
                                leftStyle: leftSideInfo,
                                rightStyle: rightSideInfoPrimaryColor),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Premium Carwash',
                                rightText: '₹499',
                                leftStyle: leftSide14SemiBold,
                                rightStyle: rightSide12SemiBold),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Interior cleaning',
                                rightText: '₹1199',
                                leftStyle: leftSide14SemiBold,
                                rightStyle: rightSide12SemiBold),
                            verticalMargin8,
                            Divider(),
                            verticalMargin8,
                            Text('Payment Summary', style: leftSide14SemiBold),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Item Total',
                                rightText: '₹${bookingDetail.payment!.amount}',
                                leftStyle: leftSideInfo,
                                rightStyle: rightSide12SemiBold),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Taxes',
                                rightText: '₹0',
                                leftStyle: leftSideInfo,
                                rightStyle: rightSide12SemiBold),
                            verticalMargin8,
                            getDetailsRow(
                                leftText: 'Grand Total',
                                rightText: '₹${bookingDetail.payment!.amount}',
                                leftStyle: leftSideInfo.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: kfontSize16,
                                    fontWeight: FontWeight.w600),
                                rightStyle: rightSideInfoPrimaryColor.copyWith(
                                    color: Colors.black,
                                    fontSize: kfontSize16,
                                    fontWeight: FontWeight.w600)),
                            verticalMargin8,
                          ],
                        ),
                      ),
                    ),
                    verticalMargin16,
                    Align(
                      alignment: Alignment.center,
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.calendar_today_outlined,
                            color: Colors.white),
                        label: Text(
                          'Add to calendar',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor),
                          elevation: MaterialStateProperty.all(4),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (state is BookingSummaryError) {
            return Center(
              child: Text('Failed to load'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget getDetailsRow(
      {required String leftText,
      required String rightText,
      required TextStyle leftStyle,
      required TextStyle rightStyle}) {
    return Row(
      children: <Widget>[
        Text(
          leftText,
          style: leftStyle,
        ),
        Spacer(),
        Text(rightText, style: rightStyle),
      ],
    );
  }
}
