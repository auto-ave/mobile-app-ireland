import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repos/repository.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final Repository _repository;
  ReviewBloc({required Repository repository})
      : _repository = repository,
        super(ReviewInitial());

  @override
  Stream<ReviewState> mapEventToState(
    ReviewEvent event,
  ) async* {
    if (event is GetReview) {
      yield* _mapGetReviewToState(bookingId: event.bookingId);
    } else if (event is AddReview) {
      yield* _mapAddReviewToState(reviewEntity: event.review);
    }
  }

  Stream<ReviewState> _mapGetReviewToState({required String bookingId}) async* {
    try {
      // Review review = await _repository.getReview(bookingId: bookingId);
      // yield ReviewLoaded(isReviewed: )
    } catch (e) {}
  }

  Stream<ReviewState> _mapAddReviewToState(
      {required ReviewEntity reviewEntity}) async* {
    try {
      yield AddingReview();
      Review review = await _repository.addReview(review: reviewEntity);
      yield ReviewAdded(review: review);
    } catch (e) {
      yield FailedToAddReview(message: e.toString());
    }
  }
}
