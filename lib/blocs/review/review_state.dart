part of 'review_bloc.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoading extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoaded extends ReviewState {
  final bool isReviewed;
  final Review? review;
  ReviewLoaded({
    required this.isReviewed,
    this.review,
  });
  @override
  List<Object> get props => [];
}

class ReviewError extends ReviewState {
  final String message;
  ReviewError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class AddingReview extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewAdded extends ReviewState {
  final Review review;
  ReviewAdded({
    required this.review,
  });

  @override
  List<Object?> get props => [review];
}

class FailedToAddReview extends ReviewState {
  final String message;
  FailedToAddReview({
    required this.message,
  });
  @override
  List<Object?> get props => [message];
}
