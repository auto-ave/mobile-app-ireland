import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              sliver: SliverToBoxAdapter(
                child: SearchBar(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Services',
                  style: kStyle20Bold.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[kHorizontalMargin16] +
                        [0, 0, 0, 0, 0, 0]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                          'assets/images/interior_cleaning.png'),
                                      kverticalMargin8,
                                      Text('Interior Cleaning')
                                    ],
                                  ),
                                ))
                            .toList(),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverToBoxAdapter(
                  child: Text(
                'Carwashes near you',
                style: kStyle20Bold.copyWith(fontWeight: FontWeight.w500),
              )),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (_, index) {
                return PopularCarwashTile();
              },
              childCount: 10,
            ))
          ],
        ),
      ),
    );
  }
}

class PopularCarwashTile extends StatelessWidget {
  const PopularCarwashTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 24,
                offset: Offset(0, 4),
                color: Color.fromRGBO(0, 0, 0, .16))
          ], borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/popular_carwash.png',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.contain,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            '3 km',
                            style: TextStyle(color: Colors.white),
                          ),
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Color.fromRGBO(0, 0, 0, 0.25))),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('3M carwash, Anand Nagar'),
                        Spacer(),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        Text('4.2')
                      ],
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: "services start @ ",
                          style: TextStyle(
                            color: Color(0xff8D8D8D),
                          ),
                        ),
                        TextSpan(
                          text: '₹499',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
