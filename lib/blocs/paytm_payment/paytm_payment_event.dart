part of 'paytm_payment_bloc.dart';

abstract class PaytmPaymentEvent extends Equatable {
  const PaytmPaymentEvent();
}

class InitiatePaytmPaymentApi extends PaytmPaymentEvent {
  final String slotStart;
  final String? slotEnd;
  final int? bay;
  final String date;
  InitiatePaytmPaymentApi({
    required this.slotStart,
    required this.slotEnd,
    required this.bay,
    required this.date,
  });
  @override
  List<Object> get props => [];
}

class CheckPaytmPaymentStatus extends PaytmPaymentEvent {
  final PaytmPaymentResponseModel paymentResponseModel;
  CheckPaytmPaymentStatus({
    required this.paymentResponseModel,
  });
  @override
  List<Object> get props => [paymentResponseModel];
}

class StartPaytmTransaction extends PaytmPaymentEvent {
  final InitiatePaytmPaymentModel initiatedPayment;
  StartPaytmTransaction({required this.initiatedPayment});
  @override
  List<Object> get props => [initiatedPayment];
}
