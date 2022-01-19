part of 'offer_list_bloc.dart';

abstract class OfferListEvent extends Equatable {
  const OfferListEvent();
}

class GetOffersList extends OfferListEvent {
  GetOffersList();
  @override
  List<Object> get props => [];
}
