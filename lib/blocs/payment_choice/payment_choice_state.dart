part of 'payment_choice_bloc.dart';

abstract class PaymentChoiceState extends Equatable {
  const PaymentChoiceState();
}

class PaymentChoiceInitial extends PaymentChoiceState {
  @override
  List<Object> get props => [];
}

class PaymentChoiceLoaded extends PaymentChoiceState {
  final List<PaymentChoice> paymentChoices;
  PaymentChoiceLoaded({
    required this.paymentChoices,
  });

  @override
  List<Object> get props => [paymentChoices];
}

class PaymentChoiceError extends PaymentChoiceState {
  final String message;
  PaymentChoiceError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class PaymentChoiceLoading extends PaymentChoiceState {
  @override
  List<Object> get props => [];
}
