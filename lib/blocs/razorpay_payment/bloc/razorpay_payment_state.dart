part of 'razorpay_payment_bloc.dart';

abstract class RazorpayPaymentState extends Equatable {
  const RazorpayPaymentState();
}

class RazorpayPaymentInitial extends RazorpayPaymentState {
  @override
  List<Object> get props => [];
}

class FailedToInitiateRazorpayPayment extends RazorpayPaymentState {
  final String message;

  FailedToInitiateRazorpayPayment({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class InitiatedRazorpayPayment extends RazorpayPaymentState {
  final InitiateRazorpayPaymentModel initiatedPayment;
  InitiatedRazorpayPayment({required this.initiatedPayment});
  @override
  // TODO: implement props
  List<Object?> get props => [initiatedPayment];
}

class InitiatingRazorpayPayment extends RazorpayPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CheckingRazorpayPaymentStatus extends RazorpayPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FailedToCheckRazorpayPaymentStatus extends RazorpayPaymentState {
  final String message;
  final String bookingId;
  FailedToCheckRazorpayPaymentStatus({
    required this.message,
    required this.bookingId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CheckedRazorpayPaymentStatus extends RazorpayPaymentState {
  final RazorpayPaymentResponse paymentResponseModel;
  final String bookingId;
  CheckedRazorpayPaymentStatus(
      {required this.paymentResponseModel, required this.bookingId});
  @override
  // TODO: implement props
  List<Object?> get props => [paymentResponseModel];
}

class RazorpayPaymentSuccess extends RazorpayPaymentState {
  final RazorpayPaymentResponse successResponse;
  final String bookingId;
  RazorpayPaymentSuccess(
      {required this.successResponse, required this.bookingId});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RazorpayPaymentFailure extends RazorpayPaymentState {
  final PaymentFailureResponse failureResponse;
  final String bookingId;
  RazorpayPaymentFailure({
    required this.failureResponse,
    required this.bookingId,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [failureResponse];
}

class RazorpayPaymentStarted extends RazorpayPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
