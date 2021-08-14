part of 'paytm_payment_bloc.dart';

abstract class PaytmPaymentEvent extends Equatable {
  const PaytmPaymentEvent();

  @override
  List<Object> get props => [];
}

class InitiatePaytmPaymentApi extends PaytmPaymentEvent {
  final String slotStart;
  final String slotEnd;
  final int bay;
  final String date;
  InitiatePaytmPaymentApi({
    required this.slotStart,
    required this.slotEnd,
    required this.bay,
    required this.date,
  });
}

class CheckPaytmPaymentStatus extends PaytmPaymentEvent {
  final PaytmPaymentResponseModel paymentResponseModel;
  CheckPaytmPaymentStatus({
    required this.paymentResponseModel,
  });
}

class StartPaytmTransaction extends PaytmPaymentEvent {
  final InitiatePaymentModel initiatedPayment;
  StartPaytmTransaction({required this.initiatedPayment});
}
