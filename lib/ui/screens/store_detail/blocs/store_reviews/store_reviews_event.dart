part of 'store_reviews_bloc.dart';

abstract class StoreReviewsEvent extends Equatable {
  const StoreReviewsEvent();
}

class LoadStoreReviews extends StoreReviewsEvent {
  final String slug;
  final int offset;
  final bool forLoadMore;
  LoadStoreReviews({
    required this.slug,
    required this.offset,
    required this.forLoadMore,
  });

  @override
  List<Object?> get props => [];
}
