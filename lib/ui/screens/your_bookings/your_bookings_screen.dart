import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/your_bookings/bloc/your_bookings_bloc.dart';

class YourBookingsScreen extends StatefulWidget {
  YourBookingsScreen({Key? key}) : super(key: key);

  @override
  _YourBookingsScreenState createState() => _YourBookingsScreenState();
}

class _YourBookingsScreenState extends State<YourBookingsScreen> {
  late YourBookingsBloc _bookingsBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookingsBloc = BlocProvider.of<YourBookingsBloc>(context);
    _bookingsBloc.add(GetYourBookings(offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text('Your Bookings'),
            ),
            BlocBuilder<YourBookingsBloc, YourBookingsState>(
              bloc: _bookingsBloc,
              builder: (context, state) {
                if (state is YourBookingsLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (state is YourBookingsLoaded) {
                  var bookings = state.bookings;

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      var booking = bookings[index];
                      return YourBookingTile(
                        address: 'Address Api',
                        serviceNames: booking.serviceNames!,
                        storeName: 'Store Name API',
                        total: booking.amount!.toString(),
                        imageUrl: 'imageUrl API',
                        bookedAt: booking.createdAt!,
                      );
                    }, childCount: bookings.length),
                  );
                }

                if (state is YourBookingsError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Center(
                        child: Text('Failed to load'),
                      ),
                    ),
                  );
                }
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class YourBookingTile extends StatefulWidget {
  YourBookingTile(
      {Key? key,
      required this.storeName,
      required this.address,
      required this.total,
      required this.serviceNames,
      required this.imageUrl,
      required this.bookedAt})
      : super(key: key);
  final String storeName;
  final String address;
  final String total;
  final List<String> serviceNames;
  final String imageUrl;
  final DateTime bookedAt;

  @override
  _YourBookingTileState createState() => _YourBookingTileState();
}

class _YourBookingTileState extends State<YourBookingTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              Image.asset(
                'assets/images/storeListImage.jpg',
                width: 50,
                height: 50,
              ),
              kHorizontalMargin8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.storeName, style: kStyle16SemiBold),
                  Text(
                    widget.address,
                    style: kStyle12.copyWith(color: Color(0xff888888)),
                  )
                ],
              ),
              Spacer(),
              Text('₹${widget.total}', style: kStyle16SemiBold)
            ]),
            Divider(),
            Text(
              'I T E M S',
              style: kStyle12SemiBold.copyWith(color: Color(0xff888888)),
            ),
            kverticalMargin4,
            ...(widget.serviceNames.map((e) => getBulletText(e)).toList()),
            kverticalMargin4,
            Text(
              'More Info',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
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
