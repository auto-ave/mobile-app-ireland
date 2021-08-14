import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/data/models/price_time_list_model.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/ui/screens/cart/cart_function_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_services/store_services_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/components/store_service_tile.dart';
import 'package:themotorwash/ui/widgets/vehicle_dropdown.dart';

class StoreServicesTab extends StatefulWidget {
  final BuildContext nestedScrollContext;
  final String storeSlug;
  final GlobalKey<ScaffoldState> scaffoldState;

  StoreServicesTab(
      {required this.nestedScrollContext,
      required this.storeSlug,
      required this.scaffoldState});

  @override
  _StoreServicesTabState createState() => _StoreServicesTabState();
}

class _StoreServicesTabState extends State<StoreServicesTab> {
  List<String> _filters = [
    '4 Wheeler',
    '2 Wheeler',
    '3 Wheeler',
    'Truck',
  ];
  late StoreServicesBloc _servicesBloc;
  late CartFunctionBloc _cartFunctionBloc;
  late GlobalAuthBloc _globalAuthBloc;
  List<PriceTimeListModel> services = [];
  List<int> cartItems = [];
  @override
  void initState() {
    super.initState();
    _servicesBloc = StoreServicesBloc(
        repository: RepositoryProvider.of<Repository>(context));
    _servicesBloc.add(
        LoadStoreServices(slug: widget.storeSlug, vehicleType: 2, offset: 0));
    _cartFunctionBloc = BlocProvider.of<CartFunctionBloc>(context);
    _globalAuthBloc = BlocProvider.of<GlobalAuthBloc>(context);

    //TODO : Vehicle Type
  }

  String? _selectedFilter;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        // This is the flip side of the SliverOverlapAbsorber
        // above.
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            widget.nestedScrollContext),
      ),
      SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: SliverToBoxAdapter(
          child: Row(
            children: [
              Expanded(
                child: VehicleDropDown(
                  valueSelected: _selectedFilter,
                  hintText: "Vehicle Type",
                  onChangedSelected: (string) {
                    setState(() {
                      _selectedFilter = string;
                    });
                  },
                  options: _filters,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: VehicleDropDown(
                valueSelected: _selectedFilter,
                hintText: "Vehicle Type",
                onChangedSelected: (string) {
                  setState(() {
                    _selectedFilter = string;
                  });
                },
                options: _filters,
              )),
            ],
          ),
        ),
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
          return BlocBuilder<StoreServicesBloc, StoreServicesState>(
            bloc: _servicesBloc,
            builder: (context, state) {
              if (state is StoreServicesLoading) {
                return SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is StoreServicesLoaded) {
                services = [];
                services = state.services;

                return SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: StoreServiceTile(
                        scaffoldState: widget.scaffoldState,
                        itemId: services[index].id!,
                        bloc: _cartFunctionBloc,
                        globalAuthBloc: _globalAuthBloc,
                        isAddedToCart:
                            getIsAddedToCart(itemId: services[index].id!),
                        isLoading: (cartFunctionState is CartFunctionLoading &&
                            (cartFunctionState)
                                .itemId
                                .contains(services[index].id!)),
                        description: services[index].description!,
                        price: services[index].price!.toString(),
                        service: services[index].service!),
                  );
                }, childCount: services.length));
              }
              if (state is StoreServicesError) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text("Failed To Load"),
                  ),
                );
              }
              return SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          );
        },
      )
    ]);
  }

  bool getIsAddedToCart({required int itemId}) {
    return cartItems.contains(itemId);
  }
}
