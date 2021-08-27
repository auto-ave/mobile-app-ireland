part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
}

class AddReview extends ReviewEvent {
  final ReviewEntity review;
  AddReview({
    required this.review,
  });
  @override
  List<Object> get props => [review];
}

class GetReview extends ReviewEvent {
  final String bookingId;
  GetReview({
    required this.bookingId,
  });
  @override
  List<Object> get props => [bookingId];
}
