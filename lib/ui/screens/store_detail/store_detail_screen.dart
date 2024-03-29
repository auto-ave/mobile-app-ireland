import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/global_cart/bloc/global_cart_bloc.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_detail_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/gallery/gallery_view.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/overview/store_overview_tab.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/reviews/store_reviews_tab.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/services/store_services_tab.dart';
import 'package:themotorwash/ui/widgets/bottom_cart_tile.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/utils/packages/flexible_title_visibility_controller/flexible_title_visibility_controller.dart';
import 'package:themotorwash/utils/utils.dart';

class StoreDetailScreen extends StatefulWidget {
  final String storeSlug;
  final String? serviceTag;
  StoreDetailScreen({Key? key, required this.storeSlug, this.serviceTag})
      : super(key: key);
  static final String route = "/storeDetails";

  @override
  _StoreDetailScreenState createState() {
    FlutterUxcam.tagScreenName(route);
    return _StoreDetailScreenState();
  }
}

class _StoreDetailScreenState extends State<StoreDetailScreen>
    with TickerProviderStateMixin {
  int _selectedTab = 0;
  late StoreDetailBloc _storeDetailBloc;
  late CartFunctionBloc _cartFunctionBloc;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  late final TabController _tabController;
  late final GlobalAuthBloc _globalAuthBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    if (widget.serviceTag != null) {
      _tabController.animateTo(1);
    }
    _storeDetailBloc = BlocProvider.of<StoreDetailBloc>(context);
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
    _globalAuthBloc = BlocProvider.of<GlobalAuthBloc>(context);
    if (_globalAuthBloc.state is Authenticated) {
      _cartFunctionBloc.add(GetCart());
    }
    _storeDetailBloc.add(LoadStoreDetail(storeSlug: widget.storeSlug));
  }

  String? storeName;

  late PersistentBottomSheetController bottomSheetController;
  final CarouselController buttonCarouselController = CarouselController();
  int carouselPageNumber = 1;
  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context).size;
    // final height = mediaQuery.height;
    // final width = mediaQuery.width;

    return Scaffold(
      // appBar: storeName != null
      //     ? getAppBarWithBackButton(
      //         context: context,
      //         title: Text(
      //           storeName!,
      //           style: SizeConfig.kStyleAppBarTitle,
      //         ))
      //     : null,
      key: _scaffoldState,
      bottomNavigationBar: BlocBuilder<StoreDetailBloc, StoreDetailState>(
        builder: (context, detailState) {
          return BlocBuilder<GlobalCartBloc, GlobalCartState>(
            builder: (context, state) {
              if (detailState is StoreDetailLoaded) {
                if (state is CartSetSuccess) {
                  return AnimatedSwitcher(
                      // transitionBuilder: AnimatedSwitcher.defaultTransitionBuilder(child, animation),
                      duration: Duration(milliseconds: 200),
                      child: state.cart.items!.isNotEmpty &&
                              detailState.store.id == state.cart.store!.id
                          ? BottomCartTile(cart: state.cart)
                          : Container(
                              width: 0,
                              height: 0,
                            ));
                  // return ;
                }
              }
              return Container(
                width: 0,
                height: 0,
              );
            },
          );
        },
      ),
      body: BlocConsumer<StoreDetailBloc, StoreDetailState>(
        bloc: _storeDetailBloc,
        listener: (_, state) {
          if (state is StoreDetailLoaded) {
            setState(() {
              storeName = state.store.name;
            });
          }
        },
        builder: (context, state) {
          if (state is StoreDetailLoading) {
            Center(
              child: loadingAnimation(),
            );
          }
          if (state is StoreDetailLoaded) {
            Store store = state.store;
            return DefaultTabController(
              initialIndex: _selectedTab,
              length: 3,
              child: NestedScrollView(
                  physics: ClampingScrollPhysics(),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverAppBar(
                        systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarColor: Colors.transparent),
                        // floating: false,
                        backgroundColor: Colors.white,
                        pinned: true,
                        elevation: 0,
                        expandedHeight: 100.w * 9 / 16 -
                            SizeConfig.mediaQueryData.padding.top,
                        iconTheme: IconThemeData(color: Colors.black),
                        // collapsedHeight: SizeConfig.mediaQueryData.padding.top,
                        // toolbarHeight: SizeConfig.mediaQueryData.padding.top,
                        automaticallyImplyLeading: false,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              color: Colors.white,
                              textColor: Colors.grey,
                              child: Icon(
                                Icons.chevron_left,
                                size: 30,
                              ),
                              shape: CircleBorder(),
                              minWidth: 38,
                            ),
                          ),
                          Spacer(),
                        ],

                        flexibleSpace: FlexibleSpaceBar(
                          title: FlexibleTitleVisibilityController(
                            child: Text(
                              storeName ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                          centerTitle: false,
                          background: Stack(
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    viewportFraction: 1,
                                    onPageChanged: (index, _) {
                                      setState(() {
                                        carouselPageNumber = index + 1;
                                      });
                                    }),
                                items: store.images!.map<Widget>((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return GestureDetector(
                                        onTap: () {
                                          // mixpanel?.track('Gallery View Click');
                                          Navigator.pushNamed(context,
                                              StoreGalleryViewScreen.route,
                                              arguments:
                                                  StoreGalleryViewArguments(
                                                      images: store.images!));
                                        },
                                        child: Container(
                                          color: Colors.amber,
                                          child: CachedNetworkImage(
                                            placeholder: (_, __) {
                                              return ShimmerPlaceholder();
                                            },
                                            imageUrl: i,
                                            width: 100.w,
                                            height: 100.w * 9 / 16,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      width: 40,
                                      height: 24,
                                      // padding: EdgeInsets.symmetric(
                                      //     horizontal: 8, vertical: 4),
                                      child: Center(
                                        child: Text(
                                          '$carouselPageNumber/${store.images!.length}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color:
                                              Color.fromRGBO(0, 0, 0, 0.35))),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverPersistentHeader(
                            pinned: true,
                            // floating: true,
                            delegate: _SliverTabBarDelegate(
                              TabBar(
                                controller: _tabController,
                                onTap: (index) {
                                  setState(() {
                                    _selectedTab = index;
                                  });
                                },
                                labelStyle: SizeConfig.selectedTabTextStyle,
                                unselectedLabelColor: SizeConfig.kGreyTextColor,
                                labelColor: SizeConfig.kPrimaryColor,
                                unselectedLabelStyle:
                                    SizeConfig.unSelectedTabTextStyle,
                                tabs: [
                                  new Tab(
                                    text: 'Overview',
                                    height: 60,
                                  ),
                                  new Tab(
                                    text: 'Services',
                                    height: 60,
                                  ),
                                  new Tab(
                                    text: 'Reviews',
                                    height: 60,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ];
                  },
                  body: Builder(
                    builder: (context) {
                      return TabBarView(
                        // physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: getSelectedTabPage(context, store),
                      );
                      // return Padding(
                      //   padding: const EdgeInsets.only(top: 16),
                      //   child: getSelectedTabPage(context, _selectedTab, state.store),
                      // );
                    },
                  )),
            );
          }
          if (state is StoreDetailError) {
            return Center(
              child: ErrorScreen(
                ctaType: ErrorCTA.reload,
                onCTAPressed: () {
                  if (_globalAuthBloc.state is Authenticated) {
                    _cartFunctionBloc.add(GetCart());
                  }
                  _storeDetailBloc
                      .add(LoadStoreDetail(storeSlug: widget.storeSlug));
                },
              ),
            );
          }
          return Center(
            child: loadingAnimation(),
          );
        },
      ),
    );
  }

  List<Widget> getSelectedTabPage(
      BuildContext nestedScrollContext, Store store) {
    List<Widget> tabPages = [
      StoreOverviewTab(
        onPressedBook: () {
          setState(() {
            _selectedTab = 1;
            _tabController.animateTo(1);
          });
        },
        onPressedRating: () {
          setState(() {
            _selectedTab = 2;
            _tabController.animateTo(2);
          });
        },
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
        store: store,
      ),
      StoreServicesTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
        scaffoldState: _scaffoldState,
        serviceTag: widget.serviceTag,
      ),
      StoreReviewsTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
      ),
    ];
    return tabPages;
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 12,
          color: Color.fromRGBO(0, 0, 0, .16),
        )
      ]),
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
