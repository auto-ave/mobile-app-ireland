import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/blocs/paytm_payment/paytm_payment_bloc.dart';
import 'package:themotorwash/blocs/slot_selection/bloc/slot_selection_bloc.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/initiate_paytm_payment.dart';
import 'package:themotorwash/data/models/multi_day_slot.dart';
import 'package:themotorwash/data/models/multi_day_slot_detail.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/payment_choice/payment_choice.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/services/components/vehicle_selected_info.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils/utils.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';

class OrderReviewScreen extends StatefulWidget {
  final DateTime dateSelected;
  final bool isMultiDay;
  static final String route = '/orderReview';
  const OrderReviewScreen(
      {Key? key, required this.dateSelected, required this.isMultiDay})
      : super(key: key);

  @override
  _OrderReviewScreenState createState() {
    FlutterUxcam.tagScreenName(route);
    return _OrderReviewScreenState();
  }
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  final TextStyle rightSideInfoPrimaryColor =
      SizeConfig.kStyle14.copyWith(color: SizeConfig.kPrimaryColor);
  // TextStyle(
  //     color: SizeConfig.kPrimaryColor,
  //     fontWeight: FontWeight.w400,
  //     fontSize: SizeConfig.kfontSize14);
  final TextStyle leftSideInfo = SizeConfig.kStyle14;
  // TextStyle(fontWeight: FontWeight.w400, fontSize: SizeConfig.kfontSize14);
  final TextStyle leftSide14W500 = SizeConfig.kStyle14W500;
  // TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize14);
  final TextStyle rightSide14W500 = SizeConfig.kStyle14W500;
  // TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize14);
  final TextStyle headingTextStyle = SizeConfig.kStyle14W500
      .copyWith(color: Colors.grey[700], letterSpacing: 1.8);

  late OrderReviewBloc _orderReviewBloc;

  @override
  void initState() {
    super.initState();

    _orderReviewBloc = BlocProvider.of<OrderReviewBloc>(context);
  }

  DateFormat formatter = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderReviewBloc, OrderReviewState>(
      bloc: _orderReviewBloc,
      builder: (context, state) {
        if (state is LocalOrderRetrieved) {
          return Scaffold(
            appBar: getAppBarWithBackButton(
                context: context,
                title: Text(
                  'Review Order',
                  style: SizeConfig.kStyleAppBarTitle,
                )),
            bottomNavigationBar:
                buildBottom(slot: state.slot, multiDaySlot: state.multiDaySlot),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStoreDetails(store: state.cart.store!),
                    SizeConfig.kverticalMargin24,
                    _buildCarTypeDetails(vehicle: state.cart.vehicleModel!),
                    SizeConfig.kverticalMargin24,
                    state.multiDaySlot != null
                        ? _buildMultiDaySlotTiming(
                            multiDaySlot: state.multiDaySlot!)
                        : _buildSlotTiming(slot: state.slot!),
                    SizeConfig.kverticalMargin24,
                    ..._buildServices(cart: state.cart),
                    ..._buildListPriceInfo(cart: state.cart),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: getAppBarWithBackButton(
              context: context,
              title: Text(
                'Review Order',
                style: SizeConfig.kStyleAppBarTitle,
              )),
          body: Center(child: loadingAnimation()),
        );
      },
    );
  }

  Widget _buildStoreDetails({required Store store}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('STORE', style: headingTextStyle),
        SizeConfig.kverticalMargin4,
        Text(
          '${store.name!}',
          style:
              SizeConfig.kStyle16W500.copyWith(color: SizeConfig.kPrimaryColor),
        )
      ],
    );
  }

  Widget _buildCarTypeDetails({required VehicleModel vehicle}) {
    return VehicleSelectedInfo(
      vehicleModel: vehicle,
      showChangeButton: false,
    );
  }

  Widget _buildMultiDaySlotTiming({required MultiDaySlot multiDaySlot}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('VEHICLE DROP TIME', style: headingTextStyle),
        SizeConfig.kverticalMargin8,
        Text(
          '${formatter.format(widget.dateSelected)}',
          style: SizeConfig.kStyle14,
        ),
        Divider(
          height: 32,
          thickness: 1,
        ),
        Text('ESTIMATED COMPLETION TIME', style: headingTextStyle),
        SizeConfig.kverticalMargin8,
        Text(
          '${multiDaySlot.estimatedCompleteTime}',
          style: SizeConfig.kStyle14,
        ),
      ],
    );
  }

  Widget _buildSlotTiming({required Slot slot}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('SLOT TIMING', style: headingTextStyle),
        SizeConfig.kverticalMargin8,
        Text(
          '${formatter.format(widget.dateSelected)}',
          style: SizeConfig.kStyle14,
        ),
        SizeConfig.kverticalMargin8,
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: SizeConfig.kPrimaryColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '${getStringFromTime(slot.start!)} - ${getStringFromTime(slot.end!)}',
            style: SizeConfig.kStyle14W500
                .copyWith(color: SizeConfig.kPrimaryColor),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildServices({required CartModel cart}) {
    return [
      Text('SERVICES', style: headingTextStyle),
      ...(cart.itemsObj!
          .map((e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizeConfig.kverticalMargin8,
                  getDetailsRow(
                      leftText: e.service,
                      rightText: '${e.price}'.euro(),
                      leftStyle: leftSide14W500,
                      rightStyle: rightSide14W500),
                  SizeConfig.kverticalMargin8
                ],
              ))
          .toList())
    ];
  }

  List<Widget> _buildListPriceInfo({required CartModel cart}) {
    return [
      Divider(
        height: 16,
      ),
      getDetailsRow(
          leftText: 'Item Total',
          rightText: '${cart.total}'.euro(),
          leftStyle: leftSideInfo,
          rightStyle: rightSide14W500),
      SizeConfig.kverticalMargin8,
      getDetailsRow(
          leftText: 'Taxes',
          rightText: '0'.euro(),
          leftStyle: leftSideInfo,
          rightStyle: rightSide14W500),
      Divider(
        height: 16,
      ),
      getDetailsRow(
          leftText: 'Grand Total',
          rightText: '${cart.total}'.euro(),
          leftStyle: leftSideInfo.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: SizeConfig.kfontSize16,
              fontWeight: FontWeight.w600),
          rightStyle: rightSideInfoPrimaryColor.copyWith(
              color: Colors.black,
              fontSize: SizeConfig.kfontSize16,
              fontWeight: FontWeight.w600)),
      SizeConfig.kverticalMargin8,
    ];
  }

  Widget getDetailsRow(
      {required String leftText,
      required String rightText,
      required TextStyle leftStyle,
      required TextStyle rightStyle}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            leftText,
            style: leftStyle,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(rightText, style: rightStyle),
      ],
    );
  }

  Widget buildBottom({Slot? slot, MultiDaySlot? multiDaySlot}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Divider(
              thickness: 1,
            ),
            Container(
              width: SizeConfig.screenWidth,
              child: CommonTextButton(
                child: Text(
                  'Proceed to payment',
                  style: SizeConfig.kStyle14W500.copyWith(
                    color: Colors.white,
                  ),
                  textScaleFactor: 1,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(PaymentChoiceScreen.route,
                      arguments: PaymentChoiceScreenArguments(
                          slot: slot,
                          dateSelected: widget.dateSelected,
                          multiDaySlot: multiDaySlot));
                },
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 16),
                buttonSemantics: 'Proceed To Payment',
                // style: ButtonStyle(
                //     padding: MaterialStateProperty.all(
                //         EdgeInsets.symmetric(horizontal: 16)),
                //     backgroundColor: MaterialStateProperty.all(Colors.green)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getStringFromTime(TimeOfDay time) {
    return time.format(context).replaceAll(' ', '');
  }
}
