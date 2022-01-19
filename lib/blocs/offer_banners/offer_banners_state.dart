part of 'offer_banners_bloc.dart';

abstract class OfferBannersState extends Equatable {
  const OfferBannersState();
}

class OfferBannersInitial extends OfferBannersState {
  @override
  List<Object?> get props => [];
}

class OfferBannersLoaded extends OfferBannersState {
  final List<OfferModel> offers;
  // final bool hasReachedMax;
  OfferBannersLoaded({
    required this.offers,
  });

  @override
  List<Object?> get props => [offers];
}

class OfferBannersLoading extends OfferBannersState {
  @override
  List<Object?> get props => [];
}

// class MoreOfferListLoading extends OfferListState {
//   @override
//   List<Object?> get props => [];
// }

class OfferBannersError extends OfferBannersState {
  final String message;
  OfferBannersError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
