import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:themotorwash/data/models/booking_list_model.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/your_bookings/bloc/your_bookings_bloc.dart';
import 'package:themotorwash/ui/screens/your_bookings/components/your_bookings_tile.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/utils.dart';

class YourBookingsScreen extends StatefulWidget {
  static final String route = '/yourBookingsScreen';
  YourBookingsScreen({Key? key}) : super(key: key);

  @override
  _YourBookingsScreenState createState() => _YourBookingsScreenState();
}

class _YourBookingsScreenState extends State<YourBookingsScreen> {
  late YourBookingsBloc _bookingsBloc;
  List<BookingListModel> bookings = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bookingsBloc = BlocProvider.of<YourBookingsBloc>(context);
    _bookingsBloc.add(GetYourBookings(offset: 0, forLoadMore: false));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBarWithBackButton(context: context),
        body: LazyLoadScrollView(
          onEndOfPage: _bookingsBloc.hasReachedMax(_bookingsBloc.state, true)
              ? () {}
              : () {
                  if (_bookingsBloc.state is YourBookingsLoaded) {
                    _bookingsBloc.add(GetYourBookings(
                        offset: bookings.length, forLoadMore: true));
                  }
                },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Your Bookings',
                    style: SizeConfig.kStyle20W500,
                  ),
                ),
              ),
              BlocBuilder<YourBookingsBloc, YourBookingsState>(
                bloc: _bookingsBloc,
                builder: (context, state) {
                  if (state is YourBookingsLoading) {
                    return SliverFillRemaining(
                      child: Center(
                        child: loadingAnimation(),
                      ),
                    );
                  }
                  if (state is YourBookingsLoaded ||
                      state is MoreYourBookingsLoading) {
                    if (state is YourBookingsLoaded) {
                      bookings = state.bookings;
                    }

                    return bookings.length == 0
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text('No bookings'),
                            ),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate((_, index) {
                              var booking = bookings[index];

                              var tile = YourBookingTile(
                                status: booking.status,
                                address: booking.store!.address!,
                                serviceNames: booking.serviceNames!,
                                storeName: booking.store!.name!,
                                total: booking.amount != null
                                    ? booking.amount!.toString()
                                    : 'Amount',
                                imageUrl: booking.store!.thumbnail!,
                                bookedAt: booking.createdAt!,
                                bookingId: booking.bookingId!,
                                scheduledOn: booking.event!.startDateTime,
                              );
                              if (state is MoreYourBookingsLoading &&
                                  index == bookings.length - 1) {
                                return LoadingMoreTile(tile: tile);
                              }
                              return tile;
                            }, childCount: bookings.length),
                          );
                  }

                  if (state is YourBookingsError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: ErrorScreen(
                          ctaType: ErrorCTA.reload,
                          onCTAPressed: () {
                            _bookingsBloc.add(
                                GetYourBookings(offset: 0, forLoadMore: false));
                          },
                        ),
                      ),
                    );
                  }
                  return SliverFillRemaining(
                    child: Center(
                      child: loadingAnimation(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
