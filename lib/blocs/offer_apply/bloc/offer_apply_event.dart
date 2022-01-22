part of 'offer_apply_bloc.dart';

abstract class OfferApplyEvent extends Equatable {
  const OfferApplyEvent();
}

class ApplyOffer extends OfferApplyEvent {
  final String code;
  ApplyOffer({
    required this.code,
  });
  @override
  List<Object> get props => [];
}

class RemoveOffer extends OfferApplyEvent {
  @override
  List<Object> get props => [];
}
