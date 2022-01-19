part of 'offer_apply_bloc.dart';

abstract class OfferApplyState extends Equatable {
  const OfferApplyState();
}

class OfferApplyInitial extends OfferApplyState {
  @override
  List<Object> get props => [];
}

class OfferApplySuccess extends OfferApplyState {
  final CartModel cart;
  OfferApplySuccess({
    required this.cart,
  });
  @override
  List<Object> get props => [cart];
}

class OfferApplyError extends OfferApplyState {
  final String message;
  OfferApplyError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class OfferApplyLoading extends OfferApplyState {
  @override
  List<Object> get props => [];
}
