import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';

class BookingSummaryScreen extends StatelessWidget {
  BookingSummaryScreen({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
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
      body: Center(
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
                        Text('We have sent a recipt on your number and email',
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
                      fontWeight: FontWeight.w600, fontSize: kfontSize20)),
              verticalMargin8,
              DottedBorder(
                dashPattern: [8, 4],
                color: Theme.of(context).primaryColor,
                borderType: BorderType.Rect,
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffF3F8FF)),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getDetailsRow(
                          leftText: 'Booking Id',
                          rightText: '123432234',
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
                          rightText: '24 June 2021',
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
                          rightText: '₹1798',
                          leftStyle: leftSideInfo,
                          rightStyle: rightSide12SemiBold),
                      verticalMargin8,
                      getDetailsRow(
                          leftText: 'Taxes',
                          rightText: '₹323.64',
                          leftStyle: leftSideInfo,
                          rightStyle: rightSide12SemiBold),
                      verticalMargin8,
                      getDetailsRow(
                          leftText: 'Grand Total',
                          rightText: '₹1721.64',
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
                  icon:
                      Icon(Icons.calendar_today_outlined, color: Colors.white),
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
