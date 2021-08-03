import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themotorwash/data/models/review.dart';

import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_reviews/store_reviews_bloc.dart';

class StoreReviewsTab extends StatefulWidget {
  final BuildContext nestedScrollContext;
  final String storeSlug;
  StoreReviewsTab({required this.nestedScrollContext, required this.storeSlug});

  @override
  _StoreReviewsTabState createState() => _StoreReviewsTabState();
}

class _StoreReviewsTabState extends State<StoreReviewsTab> {
  late StoreReviewsBloc _reviewsBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewsBloc = BlocProvider.of<StoreReviewsBloc>(context);
    _reviewsBloc.add(LoadStoreReviews(slug: widget.storeSlug, offset: 0));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        // This is the flip side of the SliverOverlapAbsorber
        // above.
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            widget.nestedScrollContext),
      ),
      BlocBuilder<StoreReviewsBloc, StoreReviewsState>(
        bloc: _reviewsBloc,
        builder: (context, state) {
          if (state is StoreReviewsLoaded) {
            var reviews = state.reviews;
            return SliverList(
                delegate: SliverChildBuilderDelegate((_, index) {
              Review review = reviews[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: StoreReviewTile(
                  customerName: review.customerName!,
                  date: review.createdAt!,
                  rating: review.rating!,
                  reviewDescription: review.reviewDescription!,
                ),
              );
            }, childCount: reviews.length));
          }
          if (state is StoreReviewsLoading) {
            return SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is StoreReviewsError) {
            return SliverFillRemaining(
              child: Center(
                child: Text('Failed to load'),
              ),
            );
          }
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      )
    ]);
  }
}

class StoreReviewTile extends StatelessWidget {
  final String reviewDescription;
  final String customerName;
  final DateTime date;
  final String rating;
  StoreReviewTile({
    Key? key,
    required this.reviewDescription,
    required this.customerName,
    required this.date,
    required this.rating,
  }) : super(key: key);

  DateFormat formatter = DateFormat('MMMMy');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: kPrimaryColor, width: 1),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 16,
              ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: TextStyle(color: kPrimaryColor, fontSize: 14),
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
          Text(reviewDescription)
        ],
      ),
    );
  }
}
