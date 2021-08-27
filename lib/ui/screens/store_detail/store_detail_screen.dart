import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/data/models/cart.dart';
import 'package:themotorwash/data/models/store.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_detail_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/components/cart_bottom_sheet.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/store_overview_tab.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/store_reviews_tab.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/store_services_tab.dart';
import 'package:themotorwash/utils.dart';

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
  late OrderReviewBloc _orderReviewBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeDetailBloc = BlocProvider.of<StoreDetailBloc>(context);
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
    _cartFunctionBloc.add(GetCart());
    _storeDetailBloc.add(LoadStoreDetail(storeSlug: widget.storeSlug));

    _orderReviewBloc = BlocProvider.of<OrderReviewBloc>(context, listen: false);
  }

  String? storeName;

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
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final height = mediaQuery.height;
    final width = mediaQuery.width;

    return SafeArea(
      child: Scaffold(
        appBar: storeName != null
            ? getAppBarWithBackButton(
                context: context,
                title: Text(
                  storeName!,
                  style: kStyle14.copyWith(color: Colors.black),
                ))
            : null,
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
                    return state.cart.items!.isNotEmpty &&
                            detailState.store.id == state.cart.store
                        ? getBottonNav(
                            cart: state.cart, store: (detailState).store)
                        : Container(
                            width: 0,
                            height: 0,
                          );
                  }

                  if (state is CartItemDeleted) {
                    return state.cart.items!.isNotEmpty &&
                            detailState.store.id == state.cart.store
                        ? getBottonNav(
                            cart: state.cart, store: (detailState).store)
                        : Container(
                            width: 0,
                            height: 0,
                          );
                  }
                  if (state is CartLoaded) {
                    return state.cart.items!.isNotEmpty &&
                            detailState.store.id == state.cart.store
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
        body: BlocConsumer<StoreDetailBloc, StoreDetailState>(
          bloc: _storeDetailBloc,
          listener: (_, state) {
            if (state is StoreDetailLoaded) {
              setState(() {
                storeName = state.store.name;
              });
              _orderReviewBloc.add(SetStore(store: state.store));
            }
          },
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
                        items: store.images!.map<Widget>((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return CachedNetworkImage(
                                imageUrl: i,
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
                                new Tab(text: "Services"),
                                new Tab(text: "Reviews"),
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
      StoreServicesTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
        scaffoldState: _scaffoldState,
      ),
      StoreReviewsTab(
        nestedScrollContext: nestedScrollContext,
        storeSlug: widget.storeSlug,
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
