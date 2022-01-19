part of 'offer_banners_bloc.dart';

abstract class OfferBannersEvent extends Equatable {
  const OfferBannersEvent();
}

class GetOffersBanners extends OfferBannersEvent {
  GetOffersBanners();
  @override
  List<Object> get props => [];
}
