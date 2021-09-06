import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/blocs/paytm_payment/paytm_payment_bloc.dart';
import 'package:themotorwash/blocs/slot_selection/bloc/slot_selection_bloc.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/order_review/order_review.dart';
import 'package:themotorwash/ui/screens/slot_select/components/date_selection_tab.dart';
import 'package:themotorwash/ui/screens/slot_select/components/slot_selection_tab.dart';
import 'package:themotorwash/utils.dart';

class SlotSelectScreen extends StatefulWidget {
  SlotSelectScreen({Key? key, required this.cartTotal, required this.cartId})
      : super(key: key);
  final String cartTotal;
  final String cartId;
  static final String route = '/slotSelect';
  @override
  _SlotSelectScreenState createState() => _SlotSelectScreenState();
}

class _SlotSelectScreenState extends State<SlotSelectScreen> {
  int currentSelectedSlotIndex = -1;
  int currentSelectedDateIndex = -1;
  late DateTime sevenDaysFromNow;
  List<DateTime> calendarDays = [];

  late SlotSelectionBloc _bloc;

  late OrderReviewBloc _orderReviewBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i <= 6; i++) {
      calendarDays.add(DateTime.now().add(Duration(days: i)));
    }
    _bloc = SlotSelectionBloc(
        repository: RepositoryProvider.of<Repository>(context));

    _orderReviewBloc = BlocProvider.of<OrderReviewBloc>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithBackButton(
          context: context,
          title: Text(
            'Select Slot',
            style: kStyle14SemiBold.copyWith(color: Colors.black),
          )),
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottom(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kverticalMargin8,
          DateSelectionTab(
              dates:
                  calendarDays.map((e) => DateSelectionItem(date: e)).toList(),
              currentSelectedTabIndex: currentSelectedDateIndex,
              onTap: (index) {
                setState(() {
                  currentSelectedDateIndex = index;
                  currentSelectedSlotIndex = -1;
                });
                _bloc.add(GetSlots(
                    date: DateFormat('y-M-d').format(calendarDays[index]),
                    cartId: widget.cartId));
              }),
          currentSelectedDateIndex >= 0
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Text(
                      'Slots on  ${calendarDays[currentSelectedDateIndex].day}',
                      style: kStyle20Bold),
                )
              : Container(),
          kverticalMargin16,
          Expanded(
              child: BlocBuilder<SlotSelectionBloc, SlotSelectionState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is SlotSelectionInitial) {
                return Center(child: Text('Select a Date'));
              }
              if (state is LoadingSlots) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SlotsLoaded) {
                var slots = state.slots;
                return
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child:
                    SlotSelectionTab(
                  slots: slots
                      .map<SlotSelectionTabItem>(
                        (e) => SlotSelectionTabItem(
                          startTime:
                              e.start!.format(context).replaceAll(' ', ''),
                          endTime: e.end!.format(context).replaceAll(' ', ''),
                          slotsAvailable: e.count!,
                        ),
                      )
                      .toList(),
                  currentSelectedTabIndex: currentSelectedSlotIndex,
                  onTap: (int tabIndex) {
                    setState(() {
                      currentSelectedSlotIndex = tabIndex;
                    });
                  },
                  // ),
                );
              }
              if (state is SlotSelectionError) {
                return Center(child: Text('Failed to load. ${state.message}'));
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('₹${widget.cartTotal}',
                  style: TextStyle(
                      fontSize: kfontSize16, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 4,
              ),
              Text(
                'T O T A L',
                style:
                    TextStyle(fontSize: kfontSize12, color: Colors.grey[700]),
              ),
            ],
          ),
          Spacer(),
          TextButton(
            child: Text('Proceed', style: TextStyle(color: Colors.white)),
            onPressed: () {
              SlotSelectionState state = _bloc.state;
              if (currentSelectedSlotIndex >= 0 &&
                  state is SlotsLoaded &&
                  currentSelectedDateIndex >= 0) {
                Slot slot = state.slots[currentSelectedSlotIndex];
                _orderReviewBloc.add(SetSlot(slot: slot));
                Navigator.pushNamed(context, OrderReviewScreen.route,
                    arguments: OrderReviewScreenArguments(
                        dateSelected: calendarDays[currentSelectedDateIndex]));
                // _paytmPaymentBloc.add(
                //   InitiatePaytmPaymentApi(
                //     slotStart: slot.start!.format(context),
                //     slotEnd: slot.end!.format(context),
                //     bay: slot.bays![0],
                //     date: DateFormat('y-M-d').format(
                //       calendarDays[currentSelectedDateIndex],
                //     ),
                //   ),
                // );
              }
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green)),
          ),
        ],
      ),
    );
  }
}
