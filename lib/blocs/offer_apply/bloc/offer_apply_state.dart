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
  final OfferSuccess offerSuccessType;
  OfferApplySuccess({required this.cart, required this.offerSuccessType});
  @override
  List<Object> get props => [cart, offerSuccessType];
}

class OfferApplyError extends OfferApplyState {
  final String message;
  final OfferError offerErrorType;
  OfferApplyError({required this.message, required this.offerErrorType});
  @override
  List<Object> get props => [message, offerErrorType];
}

class OfferApplyLoading extends OfferApplyState {
  @override
  List<Object> get props => [];
}

enum OfferError { remove, apply }
enum OfferSuccess { remove, apply }
