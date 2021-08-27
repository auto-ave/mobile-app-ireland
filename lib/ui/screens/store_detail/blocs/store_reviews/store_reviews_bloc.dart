import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repos/repository.dart';

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
          slug: event.slug,
          offset: event.offset,
          forLoadMore: event.forLoadMore);
    }
  }

  bool hasReachedMax(StoreReviewsState state) =>
      state is StoreReviewsLoaded && state.hasReachedMax;

  Stream<StoreReviewsState> _mapLoadStoreReviewsToState(
      {required String slug,
      required int offset,
      required bool forLoadMore}) async* {
    if (!hasReachedMax(state)) {
      try {
        List<Review> reviews = [];
        if (state is StoreReviewsLoaded && forLoadMore) {
          reviews = (state as StoreReviewsLoaded).reviews;
          yield MoreStoreReviewsLoading();
        } else {
          yield StoreReviewsLoading();
        }

        List<Review> moreReviews =
            await _repository.getStoreReviewsBySlug(slug: slug, offset: offset);
        yield StoreReviewsLoaded(
            reviews: reviews + moreReviews,
            hasReachedMax: moreReviews.length !=
                10); // Page Limit set in apiconstants is 10. Therefore if services retured are less than 10, then hasReachedMax is true
      } catch (e) {
        yield StoreReviewsError(message: e.toString());
      }
    }
  }
}
