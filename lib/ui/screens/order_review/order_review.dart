import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/blocs/paytm_payment/paytm_payment_bloc.dart';
import 'package:themotorwash/blocs/slot_selection/bloc/slot_selection_bloc.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/data/models/vehicle_model.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/services/components/vehicle_selected_info.dart';
import 'package:themotorwash/utils/utils.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';

class OrderReviewScreen extends StatefulWidget {
  final DateTime dateSelected;
  static final String route = '/orderReview';
  const OrderReviewScreen({
    Key? key,
    required this.dateSelected,
  }) : super(key: key);

  @override
  _OrderReviewScreenState createState() => _OrderReviewScreenState();
}

class _OrderReviewScreenState extends State<OrderReviewScreen> {
  final TextStyle rightSideInfoPrimaryColor = TextStyle(
      color: SizeConfig.kPrimaryColor,
      fontWeight: FontWeight.w400,
      fontSize: SizeConfig.kfontSize14);
  final TextStyle leftSideInfo =
      TextStyle(fontWeight: FontWeight.w400, fontSize: SizeConfig.kfontSize14);
  final TextStyle leftSide14W500 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize14);
  final TextStyle rightSide14W500 =
      TextStyle(fontWeight: FontWeight.w600, fontSize: SizeConfig.kfontSize14);
  final TextStyle headingTextStyle = SizeConfig.kStyle14W500
      .copyWith(color: Colors.grey[700], letterSpacing: 1.8);
  late SlotSelectionBloc _bloc;
  late PaytmPaymentBloc _paytmPaymentBloc;
  late SimpleFontelicoProgressDialog _dialog;
  late OrderReviewBloc _orderReviewBloc;

  void showDialog(String message) async {
    _dialog.show(
        message: message,
        height: MediaQuery.of(context).size.height * .3,
        width: MediaQuery.of(context).size.height * .4,
        type: SimpleFontelicoProgressDialogType.normal);
  }

  @override
  void initState() {
    super.initState();
    _bloc = SlotSelectionBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _paytmPaymentBloc = PaytmPaymentBloc(
        paymentRepository: RepositoryProvider.of<PaymentRepository>(context));
    _dialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    _orderReviewBloc = BlocProvider.of<OrderReviewBloc>(context);
  }

  DateFormat formatter = DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaytmPaymentBloc, PaytmPaymentState>(
        bloc: _paytmPaymentBloc,
        listener: (context, state) {
          if (state is InitiatingPaytmPayment) {
            showDialog('Initiating your transaction...Please wait');
          }
          if (state is PaytmPaymentInitiated) {
            startPaytmTransaction(initiatedPayment: state.initiatedPayment);
          }
          if (state is FailedToInitiatePaytmPayment) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to initiate payment.')));
            _dialog.hide();
          }
          if (state is PaytmPaymentSuccessful) {
            _paytmPaymentBloc.add(CheckPaytmPaymentStatus(
                paymentResponseModel: state.paymentResponseModel));
          }
          if (state is PaytmPaymentFailed) {
            if (state.e!.details == null) {
              _dialog.hide();
              showSnackbar(
                  context, "Error processing your payment. Please try again.");
            } else {
              print(jsonDecode(
                    jsonEncode(state.e!.details),
                  ).toString() +
                  "lolz");
              _paytmPaymentBloc.add(CheckPaytmPaymentStatus(
                paymentResponseModel: PaytmPaymentResponseModel.fromEntity(
                  PaytmPaymentResponseEntity.fromJson(
                    jsonDecode(
                      jsonEncode(state.e!.details),
                    ),
                  ),
                ),
              ));
            }
          }
          if (state is CheckingPaytmPaymentStatus) {
            _dialog.hide();
            showDialog('Checking payment status..Please wait!');
          }
          if (state is FailedToCheckPaytmPaymentStatus) {
            _dialog.hide();
            showSnackbar(context, 'Transaction Failed. ' + state.message);
          }
          if (state is CheckedPaytmPaymentStatus) {
            _dialog.hide();
            print(state.paymentResponseModel.toString() + "ezepz");
            Navigator.pushNamedAndRemoveUntil(
                context, BookingSummaryScreen.route, (route) => false,
                arguments: BookingSummaryScreenArguments(
                    isTransactionSuccesful:
                        state.paymentResponseModel.status == "TXN_SUCCESS",
                    bookingId: state.paymentResponseModel.orderId!));
          }
        },
        child: BlocBuilder<OrderReviewBloc, OrderReviewState>(
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
                bottomNavigationBar: buildBottom(slot: state.slot),
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
                        _buildSlotTiming(slot: state.slot),
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
        ));
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
                      rightText: '₹${e.price}',
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
          rightText: '₹${cart.total}',
          leftStyle: leftSideInfo,
          rightStyle: rightSide14W500),
      SizeConfig.kverticalMargin8,
      getDetailsRow(
          leftText: 'Taxes',
          rightText: '₹0',
          leftStyle: leftSideInfo,
          rightStyle: rightSide14W500),
      Divider(
        height: 16,
      ),
      getDetailsRow(
          leftText: 'Grand Total',
          rightText: '₹${cart.total}',
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
        Text(
          leftText,
          style: leftStyle,
        ),
        Spacer(),
        Text(rightText, style: rightStyle),
      ],
    );
  }

  Widget buildBottom({required Slot slot}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Divider(
            thickness: 1,
          ),
          TextButton(
            child: Text('Proceed to payment',
                style: SizeConfig.kStyle16W500.copyWith(color: Colors.white)),
            onPressed: () {
              _paytmPaymentBloc.add(
                InitiatePaytmPaymentApi(
                  slotStart: slot.start!.format(context),
                  slotEnd: slot.end!.format(context),
                  bay: slot.bays![0],
                  date: DateFormat('y-M-d').format(
                    widget.dateSelected,
                  ),
                ),
              );
            },
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 16)),
                backgroundColor: MaterialStateProperty.all(Colors.green)),
          ),
        ],
      ),
    );
  }

  void startPaytmTransaction({required InitiatePaymentModel initiatedPayment}) {
    _paytmPaymentBloc
        .add(StartPaytmTransaction(initiatedPayment: initiatedPayment));
  }

  String getStringFromTime(TimeOfDay time) {
    return time.format(context).replaceAll(' ', '');
  }
}
