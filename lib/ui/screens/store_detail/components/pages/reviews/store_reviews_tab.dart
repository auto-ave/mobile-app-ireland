import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:themotorwash/data/models/review.dart';
import 'package:themotorwash/data/repos/repository.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_reviews/store_reviews_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/reviews/components/no_review_widget.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/utils/utils.dart';

class StoreReviewsTab extends StatefulWidget {
  final BuildContext nestedScrollContext;
  final String storeSlug;
  StoreReviewsTab({required this.nestedScrollContext, required this.storeSlug});

  @override
  _StoreReviewsTabState createState() {
    FlutterUxcam.tagScreenName('StoreReviewTab');
    return _StoreReviewsTabState();
  }
}

class _StoreReviewsTabState extends State<StoreReviewsTab>
    with AutomaticKeepAliveClientMixin {
  late StoreReviewsBloc _reviewsBloc;
  List<Review> reviews = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewsBloc = StoreReviewsBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _reviewsBloc.add(LoadStoreReviews(
        slug: widget.storeSlug, offset: 0, forLoadMore: false));
  }

  @override
  Widget build(BuildContext context) {
    return LazyLoadScrollView(
      onEndOfPage: _reviewsBloc.hasReachedMax(_reviewsBloc.state)
          ? () {}
          : () {
              if (_reviewsBloc.state is StoreReviewsLoaded) {
                _reviewsBloc.add(LoadStoreReviews(
                    slug: widget.storeSlug,
                    offset: reviews.length,
                    forLoadMore: true));
              }
            },
      child: CustomScrollView(
          key: PageStorageKey<String>('StoreReviewsTab'),
          slivers: <Widget>[
            SliverOverlapInjector(
              // This is the flip side of the SliverOverlapAbsorber
              // above.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  widget.nestedScrollContext),
            ),
            BlocConsumer<StoreReviewsBloc, StoreReviewsState>(
              bloc: _reviewsBloc,
              listener: (_, state) {
                setState(
                    () {}); //TODO Find alternative for this workaround (Need setState for lazyloading to trigger)
              },
              builder: (context, state) {
                if (state is StoreReviewsLoaded ||
                    state is MoreStoreReviewsLoading) {
                  if (state is StoreReviewsLoaded) {
                    reviews = state.reviews;
                  }
                  return reviews.isNotEmpty
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate((_, index) {
                          Review review = reviews[index];
                          var tile = Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: StoreReviewTile(
                              userImage: review.image!,
                              customerName: review.customerName!,
                              date: review.createdAt!,
                              rating: review.rating!,
                              reviewDescription: review.reviewDescription,
                            ),
                          );

                          if (state is MoreStoreReviewsLoading &&
                              index == reviews.length - 1) {
                            return LoadingMoreTile(tile: tile);
                          }
                          return tile;
                        }, childCount: reviews.length))
                      : SliverFillRemaining(
                          child: Center(
                            child: NoReviewWidget(),
                          ),
                        );
                }
                if (state is StoreReviewsLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: loadingAnimation(),
                    ),
                  );
                }
                if (state is StoreReviewsError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: ErrorScreen(
                        ctaType: ErrorCTA.reload,
                        onCTAPressed: () {
                          _reviewsBloc.add(LoadStoreReviews(
                              slug: widget.storeSlug,
                              offset: 0,
                              forLoadMore: false));
                        },
                      ),
                    ),
                  );
                }
                return SliverFillRemaining(
                  child: Center(
                    child: loadingAnimation(),
                  ),
                );
              },
            )
          ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class StoreReviewTile extends StatelessWidget {
  final String? reviewDescription;
  final String customerName;
  final DateTime date;
  final String rating;
  final String userImage;
  StoreReviewTile({
    Key? key,
    required this.reviewDescription,
    required this.customerName,
    required this.date,
    required this.rating,
    required this.userImage,
  }) : super(key: key);

  final DateFormat formatter = DateFormat('MMMMy');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: SizeConfig.kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: userImage,
                width: 60,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: TextStyle(
                        color: SizeConfig.kPrimaryColor, fontSize: 14),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(formatter.format(date))
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: SizeConfig.kPrimaryColor, width: 1),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16,
                ),
                SizeConfig.kHorizontalMargin4,
                Text(rating),
              ],
            ),
          ),
          reviewDescription != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      height: 16,
                      thickness: 1,
                    ),
                    Text(reviewDescription ?? ""),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
