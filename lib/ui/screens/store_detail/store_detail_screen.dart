import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/cart/cart_function_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_detail_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/components/cart_bottom_sheet.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/store_overview_tab.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/store_reviews_tab.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/store_services_tab.dart';

class StoreDetailScreen extends StatefulWidget {
  final String storeSlug;
  StoreDetailScreen({Key? key, required this.storeSlug}) : super(key: key);
  static final String route = "/storeDetails";

  @override
  _StoreDetailScreenState createState() => _StoreDetailScreenState();
}

class _StoreDetailScreenState extends State<StoreDetailScreen> {
  int _selectedTab = 0;
  late StoreDetailBloc _storeDetailBloc;
  late CartFunctionBloc _cartFunctionBloc;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeDetailBloc = BlocProvider.of<StoreDetailBloc>(context);
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
    _cartFunctionBloc.add(GetCart());
    _storeDetailBloc.add(LoadStoreDetail(storeSlug: widget.storeSlug));
  }

  late PersistentBottomSheetController bottomSheetController;

  _showCartSheet({required String storeName}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8))),
        builder: (_) {
          return CartBottomSheet(
            storeName: storeName,
          );
        });
    // bottomSheetController = _scaffoldState.currentState!.showBottomSheet(
    //   (context) => CartBottomSheet(
    //     storeName: storeName,
    //   ),
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final heigth = mediaQuery.height;
    final width = mediaQuery.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        bottomNavigationBar: BlocBuilder<StoreDetailBloc, StoreDetailState>(
          builder: (context, detailState) {
            return BlocBuilder<CartFunctionBloc, CartFunctionState>(
              builder: (context, state) {
                if (detailState is StoreDetailLoaded) {
                  if (state is CartLoading) {
                    return Container(
                      width: 0,
                      height: 0,
                    );
                  }
                  if (state is CartFunctionUninitialized) {
                    return Container(
                      width: 0,
                      height: 0,
                    );
                  }
                  if (state is CartItemAdded) {
                    return state.cart.items!.isNotEmpty
                        ? getBottonNav(
                            cart: state.cart, store: (detailState).store)
                        : Container(
                            width: 0,
                            height: 0,
                          );
                  }

                  if (state is CartItemDeleted) {
                    return state.cart.items!.isNotEmpty
                        ? getBottonNav(
                            cart: state.cart, store: (detailState).store)
                        : Container(
                            width: 0,
                            height: 0,
                          );
                  }
                  if (state is CartLoaded) {
                    return state.cart.items!.isNotEmpty
                        ? getBottonNav(
                            cart: state.cart, store: (detailState).store)
                        : Container(
                            width: 0,
                            height: 0,
                          );
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
        body: BlocBuilder<StoreDetailBloc, StoreDetailState>(
          bloc: _storeDetailBloc,
          builder: (context, state) {
            if (state is StoreDetailLoading) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is StoreDetailLoaded) {
              Store store = state.store;
              return DefaultTabController(
                initialIndex: _selectedTab,
                length: 3,
                child: NestedScrollView(headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  // These are the slivers that show up in the "outer" scroll view.
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: CarouselSlider(
                        options: CarouselOptions(viewportFraction: 1),
                        items: [1, 2, 3, 4, 5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CachedNetworkImage(
                                imageUrl: store.thumbnail!,
                                width: width,
                                height: width * 3 / 5,
                                fit: BoxFit.fill,
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverTabBarDelegate(
                            TabBar(
                              onTap: (index) {
                                setState(() {
                                  _selectedTab = index;
                                });
                              },
                              labelColor: Colors.black87,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                new Tab(text: "Overview"),
                                new Tab(text: "Reviews"),
                                new Tab(text: "Services"),
                              ],
                            ),
                          )),
                    ),
                  ];
                }, body: Builder(builder: (context) {
                  return getSelectedTabPage(context, _selectedTab, state.store);
                })),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget getBottonNav({required CartModel cart, required Store store}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Divider(
          height: 1,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('${cart.items!.length} items',
                      style: TextStyle(
                          fontSize: kfontSize16, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 4,
                  ),
                  Text('₹${cart.total}',
                      style: TextStyle(
                          fontSize: kfontSize16, fontWeight: FontWeight.w500)),
                ],
              ),
              Spacer(),
              TextButton(
                child: Text('View Cart', style: TextStyle(color: Colors.white)),
                onPressed: () => _showCartSheet(storeName: store.name!),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getSelectedTabPage(
      BuildContext nestedScrollContext, int index, Store store) {
    List<Widget> tabPages = [
      StoreOverviewTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
        store: store,
      ),
      StoreReviewsTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
      ),
      StoreServicesTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
        scaffoldState: _scaffoldState,
      ),
    ];
    return tabPages[index];
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
      color: Colors.white, // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
