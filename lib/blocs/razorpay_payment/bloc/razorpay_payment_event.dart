part of 'razorpay_payment_bloc.dart';

abstract class RazorpayPaymentEvent extends Equatable {
  const RazorpayPaymentEvent();
}

class InitiateRazorpayPayment extends RazorpayPaymentEvent {
  final String slotStart;
  final String? slotEnd;
  final int? bay;
  final String date;
  InitiateRazorpayPayment({
    required this.slotStart,
    this.slotEnd,
    this.bay,
    required this.date,
  });
  @override
  List<Object> get props => [];
}

class CheckRazorpayPaymentStatus extends RazorpayPaymentEvent {
  final RazorpayPaymentResponse paymentResponseModel;
  final String bookingId;
  final bool isFailure;
  CheckRazorpayPaymentStatus({
    required this.paymentResponseModel,
    required this.bookingId,
    required this.isFailure,
  });
  @override
  List<Object> get props => [paymentResponseModel, bookingId, isFailure];
}

class StartRazorpayTransaction extends RazorpayPaymentEvent {
  final InitiateRazorpayPaymentModel initiatedPayment;
  StartRazorpayTransaction({required this.initiatedPayment});
  @override
  List<Object> get props => [initiatedPayment];
}

class EmitRazorpayPaymentSuccess extends RazorpayPaymentEvent {
  final RazorpayPaymentResponse response;
  final String bookingId;
  EmitRazorpayPaymentSuccess({
    required this.response,
    required this.bookingId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmitRazorpayPaymentFailure extends RazorpayPaymentEvent {
  final PaymentFailureResponse response;
  final String bookingId;
  EmitRazorpayPaymentFailure({
    required this.response,
    required this.bookingId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
