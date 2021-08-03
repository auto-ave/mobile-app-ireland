import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repository.dart';

part 'store_reviews_event.dart';
part 'store_reviews_state.dart';

class StoreReviewsBloc extends Bloc<StoreReviewsEvent, StoreReviewsState> {
  final Repository _repository;
  StoreReviewsBloc({required Repository repository})
      : _repository = repository,
        super(StoreReviewsInitial());
  @override
  Stream<StoreReviewsState> mapEventToState(
    StoreReviewsEvent event,
  ) async* {
    if (event is LoadStoreReviews) {
      yield* _mapLoadStoreReviewsToState(
          slug: event.slug, offset: event.offset);
    }
  }

  bool _hasReachedMax(StoreReviewsState state) =>
      state is StoreReviewsLoaded && state.hasReachedMax;

  Stream<StoreReviewsState> _mapLoadStoreReviewsToState(
      {required String slug, required int offset}) async* {
    if (!_hasReachedMax(state)) {
      try {
        if (state is StoreReviewsLoaded) {
          yield StoreReviewsLoading();
        }
        List<Review> reviews = state is StoreReviewsLoaded
            ? (state as StoreReviewsLoaded).reviews
            : [];

        List<Review> moreReviews =
            await _repository.getStoreReviewsBySlug(slug: slug, offset: offset);
        yield StoreReviewsLoaded(
            reviews: reviews + moreReviews, hasReachedMax: moreReviews.isEmpty);
      } catch (e) {
        yield StoreReviewsError(message: e.toString());
      }
    }
  }
}
