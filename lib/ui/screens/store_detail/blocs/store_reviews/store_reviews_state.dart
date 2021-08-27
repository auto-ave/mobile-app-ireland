part of 'store_reviews_bloc.dart';

abstract class StoreReviewsState extends Equatable {
  const StoreReviewsState();
}

class StoreReviewsInitial extends StoreReviewsState {
  @override
  List<Object?> get props => [];
}

class StoreReviewsLoaded extends StoreReviewsState {
  final List<Review> reviews;
  final bool hasReachedMax;
  StoreReviewsLoaded({
    required this.reviews,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [reviews, hasReachedMax];
}

class StoreReviewsLoading extends StoreReviewsState {
  @override
  List<Object?> get props => [];
}

class MoreStoreReviewsLoading extends StoreReviewsState {
  @override
  List<Object?> get props => [];
}

class StoreReviewsError extends StoreReviewsState {
  final String message;
  StoreReviewsError({required this.message});

  @override
  List<Object?> get props => [message];
}
