import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/global_vehicle_type/bloc/global_vehicle_type_bloc.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_services/store_services_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/services/components/no_service_widget.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/services/components/store_service_tile.dart';
import 'package:themotorwash/ui/screens/store_detail/components/pages/services/components/vehicle_selected_info.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/ui/widgets/error_widget.dart';
import 'package:themotorwash/ui/widgets/loading_more_tile.dart';
import 'package:themotorwash/ui/widgets/loading_widgets/shimmer_placeholder.dart';
import 'package:themotorwash/ui/widgets/vehicle_dropdown.dart';
import 'package:themotorwash/ui/widgets/vehicle_type_selection/vehicle_type_selection_bottom_sheet.dart';
import 'package:themotorwash/utils/utils.dart';

class StoreServicesTab extends StatefulWidget {
  final BuildContext nestedScrollContext;
  final String storeSlug;
  final GlobalKey<ScaffoldState> scaffoldState;
  final String? serviceTag;

  StoreServicesTab(
      {required this.nestedScrollContext,
      required this.storeSlug,
      required this.scaffoldState,
      this.serviceTag});

  @override
  _StoreServicesTabState createState() {
    FlutterUxcam.tagScreenName('StoreServicesTab');
    return _StoreServicesTabState();
  }
}

class _StoreServicesTabState extends State<StoreServicesTab>
    with AutomaticKeepAliveClientMixin {
  final PageController pageController = PageController();
  late StoreServicesBloc _servicesBloc;
  late CartFunctionBloc _cartFunctionBloc;
  late GlobalAuthBloc _globalAuthBloc;
  late GlobalVehicleTypeBloc _globalVehicleTypeBloc;
  late OrderReviewBloc _orderReviewBloc;

  List<PriceTimeListModel> services = [];
  List<int> cartItems = [];
  @override
  void initState() {
    super.initState();
    _globalVehicleTypeBloc = BlocProvider.of<GlobalVehicleTypeBloc>(context);
    _servicesBloc = StoreServicesBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _orderReviewBloc = BlocProvider.of<OrderReviewBloc>(context, listen: false);
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
    _globalVehicleTypeBloc.add(CheckSavedVehicleType());
    _globalAuthBloc = BlocProvider.of<GlobalAuthBloc>(context);
    print('hello reached here10');
  }

  String? _selectedFilter;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalVehicleTypeBloc, GlobalVehicleTypeState>(
      bloc: _globalVehicleTypeBloc,
      listener: (ctx, vehicleState) {
        print('hello reached here0');

        if (vehicleState is VehicleTypeNotSelected) {
          print('hello reached here1');
          _showVehicleBottomSheet(context);
        }
        if (vehicleState is GlobalVehicleTypeSelected) {
          _servicesBloc.add(LoadStoreServices(
              slug: widget.storeSlug,
              vehicleType: vehicleState.vehicleTypeModel.vehicleType!,
              offset: 0,
              forLoadMore: false,
              firstServiceTag: widget.serviceTag));
        }
        if (vehicleState is GlobalVehicleTypeError) {
          showSnackbar(context, 'Error Loading Vehicle Type');
        }
      },
      builder: (ctx, vehicleState) {
        return vehicleState is GlobalVehicleTypeSelected
            ? _buildServicesList(vehicleState)
            : _buildSelectVehicleTypeButton();
      },
    );
  }

  _buildServicesList(GlobalVehicleTypeSelected vehicleState) {
    return LazyLoadScrollView(
      onEndOfPage: _servicesBloc.hasReachedMax(_servicesBloc.state, true)
          ? () {}
          : () {
              if (_servicesBloc.state is StoreServicesLoaded) {
                _servicesBloc.add(LoadStoreServices(
                    slug: widget.storeSlug,
                    vehicleType: vehicleState.vehicleTypeModel.vehicleType!,
                    offset: services.length,
                    firstServiceTag: widget.serviceTag,
                    forLoadMore: true));
              }
            },
      child: CustomScrollView(
          key: PageStorageKey<String>('StoreServicesTab'),
          slivers: <Widget>[
            SliverOverlapInjector(
              // This is the flip side of the SliverOverlapAbsorber
              // above.
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  widget.nestedScrollContext),
            ),
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                  child: VehicleSelectedInfo(
                      vehicleModel: vehicleState.vehicleTypeModel,
                      showChangeButton: true,
                      onChangePressed: () => _showVehicleBottomSheet(context))),
            ),
            BlocBuilder<CartFunctionBloc, CartFunctionState>(
              bloc: _cartFunctionBloc,
              builder: (context, cartFunctionState) {
                if (cartFunctionState is CartItemAdded) {
                  cartItems = cartFunctionState.cart.items!;
                }
                if (cartFunctionState is CartItemDeleted) {
                  cartItems = cartFunctionState.cart.items!;
                }
                if (cartFunctionState is CartLoaded) {
                  cartItems = cartFunctionState.cart.items!;
                }
                return BlocConsumer<StoreServicesBloc, StoreServicesState>(
                  bloc: _servicesBloc,
                  listener: (_, state) {
                    setState(
                        () {}); //TODO Find alternative for this workaround (Need setState for lazyloading to trigger)
                  },
                  builder: (context, state) {
                    if (state is StoreServicesLoading) {
                      return SliverFillRemaining(
                        child: Center(
                          child: loadingAnimation(),
                        ),
                      );
                    }
                    if (state is StoreServicesLoaded ||
                        state is MoreStoreServicesLoading) {
                      if (state is StoreServicesLoaded) {
                        print(state.services.toString() + "he");
                        services = state.services;
                      }

                      return services.isEmpty
                          ? SliverFillRemaining(
                              child: Center(
                                child: NoServiceWidget(),
                              ),
                            )
                          : SliverList(
                              delegate: SliverChildBuilderDelegate((_, index) {
                              var service = services[index];
                              var tile = StoreServiceTile(
                                offer: service.offer,
                                vehicleModel:
                                    vehicleState.vehicleTypeModel.model!,
                                time: service.timeInterval.toString(),
                                scaffoldState: widget.scaffoldState,
                                itemId: service.id!,
                                bloc: _cartFunctionBloc,
                                globalAuthBloc: _globalAuthBloc,
                                isAddedToCart: getIsAddedToCart(
                                    itemId: services[index].id!),
                                isLoading:
                                    (cartFunctionState is CartFunctionLoading &&
                                        (cartFunctionState)
                                            .itemId
                                            .contains(services[index].id!)),
                                description: services[index].description!,
                                price: service.price!.toString(),
                                service: service.service!,
                                tags: service.tags,
                              );

                              if (state is MoreStoreServicesLoading &&
                                  index == services.length - 1) {
                                return LoadingMoreTile(tile: tile);
                              }
                              return tile;
                            }, childCount: services.length));
                    }
                    if (state is StoreServicesError) {
                      return SliverFillRemaining(
                        child: Center(
                          child: ErrorScreen(
                            ctaType: ErrorCTA.reload,
                            onCTAPressed: () {
                              _servicesBloc.add(LoadStoreServices(
                                  slug: widget.storeSlug,
                                  vehicleType: vehicleState
                                      .vehicleTypeModel.vehicleType!,
                                  offset: 0,
                                  forLoadMore: false,
                                  firstServiceTag: widget.serviceTag));
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
                );
              },
            )
          ]),
    );
  }

  _buildSelectVehicleTypeButton() {
    return CustomScrollView(
      key: PageStorageKey<String>('StoreServicesTab'),
      slivers: [
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber
          // above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
              widget.nestedScrollContext),
        ),
        SliverFillRemaining(
          child: Center(
              child: CommonTextButton(
            onPressed: () => _showVehicleBottomSheet(context),
            child: Text(
              'Select Vehicle Type',
              style: SizeConfig.kStyle14.copyWith(color: Colors.white),
            ),
            backgroundColor: SizeConfig.kPrimaryColor,
            buttonSemantics: 'Select Vehicle Type',
          )),
        )
      ],
    );
  }

  bool getIsAddedToCart({required int itemId}) {
    return cartItems.contains(itemId);
  }

  void _showVehicleBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return VehicleTypeSelectionBottomSheet(
            pageController: pageController,
            isOldRoute: false,
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
