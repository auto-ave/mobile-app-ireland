part of 'offer_list_bloc.dart';

abstract class OfferListState extends Equatable {
  const OfferListState();
}

class OfferListInitial extends OfferListState {
  @override
  List<Object?> get props => [];
}

class OfferListLoaded extends OfferListState {
  final List<OfferModel> offers;
  // final bool hasReachedMax;
  OfferListLoaded({
    required this.offers,
  });

  @override
  List<Object?> get props => [offers];
}

class OfferListLoading extends OfferListState {
  @override
  List<Object?> get props => [];
}

// class MoreOfferListLoading extends OfferListState {
//   @override
//   List<Object?> get props => [];
// }

class OfferListError extends OfferListState {
  final String message;
  OfferListError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
