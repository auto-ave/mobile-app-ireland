part of 'payment_choice_bloc.dart';

abstract class PaymentChoiceEvent extends Equatable {
  const PaymentChoiceEvent();
}

class GetPaymentChoices extends PaymentChoiceEvent {
  @override
  List<Object> get props => [];
}
