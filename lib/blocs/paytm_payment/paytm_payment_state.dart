part of 'paytm_payment_bloc.dart';

abstract class PaytmPaymentState extends Equatable {
  const PaytmPaymentState();
}

class PaytmPaymentInitial extends PaytmPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaytmPaymentStatusRetrieved extends PaytmPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PaytmPaymentInitiated extends PaytmPaymentState {
  final InitiatePaymentModel initiatedPayment;
  PaytmPaymentInitiated({
    required this.initiatedPayment,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [initiatedPayment];
}

class InitiatingPaytmPayment extends PaytmPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FailedToInitiatePaytmPayment extends PaytmPaymentState {
  final String message;
  FailedToInitiatePaytmPayment({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CheckingPaytmPaymentStatus extends PaytmPaymentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FailedToCheckPaytmPaymentStatus extends PaytmPaymentState {
  final String message;
  FailedToCheckPaytmPaymentStatus({
    required this.message,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class CheckedPaytmPaymentStatus extends PaytmPaymentState {
  final PaytmPaymentResponseModel paymentResponseModel;
  CheckedPaytmPaymentStatus({
    required this.paymentResponseModel,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [paymentResponseModel];
}

class PaytmPaymentSuccessful extends PaytmPaymentState {
  final PaytmPaymentResponseModel paymentResponseModel;
  PaytmPaymentSuccessful({
    required this.paymentResponseModel,
  });
  @override
  List<Object?> get props => [paymentResponseModel];
}

class PaytmPaymentFailed extends PaytmPaymentState {
  final String message;
  final PlatformException? e;
  PaytmPaymentFailed({
    required this.message,
    this.e,
  });
  @override
  List<Object?> get props => [message, e];
}
