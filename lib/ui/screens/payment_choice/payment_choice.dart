import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:themotorwash/blocs/payment_choice/payment_choice_bloc.dart';
import 'package:themotorwash/blocs/paytm_payment/paytm_payment_bloc.dart';
import 'package:themotorwash/data/models/initiate_payment.dart';
import 'package:themotorwash/data/models/paytm_payment_response.dart';
import 'package:themotorwash/data/models/slot.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/or_divider_widget.dart';
import 'package:themotorwash/utils/utils.dart';

class PaymentChoiceScreen extends StatefulWidget {
  static final String route = '/paymentChoice';
  final Slot slot;
  final DateTime dateSelected;
  const PaymentChoiceScreen(
      {Key? key, required this.dateSelected, required this.slot})
      : super(key: key);

  @override
  _PaymentChoiceScreenState createState() => _PaymentChoiceScreenState();
}

class _PaymentChoiceScreenState extends State<PaymentChoiceScreen> {
  int currentSelectedIndex = 1;
  late final PaymentChoiceBloc _paymentChoiceBloc;
  late PaytmPaymentBloc _paytmPaymentBloc;
  late SimpleFontelicoProgressDialog _dialog;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    _paytmPaymentBloc = PaytmPaymentBloc(
        paymentRepository: RepositoryProvider.of<PaymentRepository>(context));
    _paymentChoiceBloc = PaymentChoiceBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _paymentChoiceBloc.add(GetPaymentChoices());
  }

  void showDialog(String message) async {
    _dialog.show(
        message: message,
        height: 30.h,
        width: 40.h,
        type: SimpleFontelicoProgressDialogType.normal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBarWithBackButton(
            context: context,
            title: Text(
              'Select Payment Choice',
              style: SizeConfig.kStyleAppBarTitle,
            )),
        bottomNavigationBar: BottomButton(
          title: 'Continue',
          onTap: () {
            _paytmPaymentBloc.add(
              InitiatePaytmPaymentApi(
                slotStart: widget.slot.startString!,
                slotEnd: widget.slot.endString!,
                bay: widget.slot.bays![0],
                date: DateFormat('y-M-d').format(
                  widget.dateSelected,
                ),
              ),
            );
          },
        ),
        body: BlocListener<PaytmPaymentBloc, PaytmPaymentState>(
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
                showSnackbar(context,
                    "Error processing your payment. Please try again.");
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
          child: BlocBuilder<PaymentChoiceBloc, PaymentChoiceState>(
            bloc: _paymentChoiceBloc,
            builder: (context, state) {
              if (state is PaymentChoiceLoading) {
                return Center(
                  child: loadingAnimation(),
                );
              }
              if (state is PaymentChoiceError) {
                return Center(
                  child: ErrorScreen(
                    ctaType: ErrorCTA.reload,
                    onCTAPressed: () {
                      _paymentChoiceBloc.add(GetPaymentChoices());
                    },
                  ),
                );
              }

              if (state is PaymentChoiceLoaded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      PaymentChoiceTile(
                          amount: state.paymentChoices[0].amount.toString(),
                          descriptionWidget:
                              Text(state.paymentChoices[0].description),
                          isSelected: currentSelectedIndex == 0,
                          paymentChoice: state.paymentChoices[0].title,
                          primaryColor: Color(0xff6326C7),
                          isActive: state.paymentChoices[0].active,
                          onTap: (index) {
                            if (state.paymentChoices[0].active) {
                              setState(() {
                                currentSelectedIndex = index;
                              });
                            } else {
                              showSnackbar(context,
                                  'Option not available for the select store');
                            }
                          },
                          widgetIndex: 0),
                      SizeConfig.kverticalMargin16,
                      ORWithDividerWidget(),
                      SizeConfig.kverticalMargin16,
                      PaymentChoiceTile(
                          amount: state.paymentChoices[1].amount.toString(),
                          descriptionWidget:
                              Text(state.paymentChoices[1].description),
                          isActive: state.paymentChoices[1].active,
                          isSelected: currentSelectedIndex == 1,
                          paymentChoice: state.paymentChoices[1].title,
                          primaryColor: SizeConfig.kPrimaryColor,
                          onTap: (index) {
                            if (state.paymentChoices[1].active) {
                              setState(() {
                                currentSelectedIndex = index;
                              });
                            } else {
                              showSnackbar(context,
                                  'Option not available for the select store');
                            }
                          },
                          widgetIndex: 1),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 4),
                        child: TermsCancellation(terms: [
                          'In case of cancelling of order before 24 hours of the slot whole refund will be provided.',
                          'In case of cancelling of order after 24 hours of the slot token amount will be charged.'
                        ]),
                      )
                    ],
                  ),
                );
              }
              return ErrorScreen(
                ctaType: ErrorCTA.reload,
                onCTAPressed: () {
                  _paymentChoiceBloc.add(GetPaymentChoices());
                },
              );
            },
          ),
        ));
  }

  void startPaytmTransaction({required InitiatePaymentModel initiatedPayment}) {
    _paytmPaymentBloc
        .add(StartPaytmTransaction(initiatedPayment: initiatedPayment));
  }
}

class BottomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const BottomButton({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 4,
              color: Color.fromRGBO(0, 0, 0, .08),
              offset: Offset(0, -2))
        ]),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: <Widget>[
              Spacer(),
              CommonTextButton(
                  onPressed: onTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 8),
                    child: Text(title,
                        style: SizeConfig.kStyle14W500
                            .copyWith(color: Colors.white)),
                  ),
                  backgroundColor: SizeConfig.kPrimaryColor)
            ],
          ),
        ));
  }
}

class TermsCancellation extends StatelessWidget {
  final List<String> terms;
  const TermsCancellation({Key? key, required this.terms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        children: terms
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("\u2022 "),
                        Expanded(
                          child: Text(
                            e,
                            style: SizeConfig.kStyle12
                                .copyWith(color: SizeConfig.kGreyTextColor),
                          ),
                        ),
                      ]),
                ))
            .toList());
  }
}

class PaymentChoiceTile extends StatelessWidget {
  final String paymentChoice;
  final String amount;
  final Widget descriptionWidget;
  final bool isSelected;
  final Color primaryColor;
  final int widgetIndex;
  final Function(int index) onTap;
  final bool isActive;

  const PaymentChoiceTile(
      {Key? key,
      required this.amount,
      required this.descriptionWidget,
      required this.isSelected,
      required this.paymentChoice,
      required this.primaryColor,
      required this.onTap,
      required this.widgetIndex,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      offset: Offset(0, 8),
                      blurRadius: 24,
                      color: Color.fromRGBO(0, 0, 0, .16))
                ]
              : []),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                paymentChoice,
                style: SizeConfig.kStyle16Bold,
              ),
              Spacer(),
              Text(amount,
                  style: SizeConfig.kStyle16Bold.copyWith(color: primaryColor))
            ],
          ),
          SizeConfig.kverticalMargin8,
          descriptionWidget,
          SizeConfig.kverticalMargin16,
          GestureDetector(
            onTap: () => onTap(widgetIndex),
            child: Container(
              width: 100.w,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: Text(
                  isSelected ? 'Selected' : 'Select',
                  style: SizeConfig.kStyle16Bold.copyWith(
                      color: isSelected ? Colors.white : primaryColor),
                ),
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? (isSelected ? primaryColor : Colors.white)
                    : Colors.grey[300],
                border: Border.all(
                  color: primaryColor,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
