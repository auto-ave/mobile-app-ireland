import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/data/local/local_auth_service.dart';
import 'package:themotorwash/data/models/store_list_model.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/widgets/search_bar.dart';
import 'package:themotorwash/ui/widgets/store_tile.dart';
import 'package:themotorwash/ui/widgets/vehicle_dropdown.dart';

class StoreListScreen extends StatefulWidget {
  final String city;

  const StoreListScreen({Key? key, required this.city});
  static final String route = "/storeList";
  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  List<String> _filters = [
    '4 Wheeler',
    '2 Wheeler',
    '3 Wheeler',
    'Truck',
  ]; // Option 2
  String? _selectedFilter;
  int _pageIndex = 0;
  StoreListBloc? _storeListBloc;
  List<StoreListModel> stores = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _storeListBloc = BlocProvider.of<StoreListBloc>(context);
    _storeListBloc!.add(LoadStoreListByCityPressed(offset: 0, city: '462001'));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Icon(Icons.chevron_left),
          actions: [
            TextButton(
              child: Text("Logout"),
              onPressed: () async {
                await LocalAuthService().removeTokens();
                BlocProvider.of<GlobalAuthBloc>(context)
                  ..add(CheckAuthStatus());
              },
            )
          ],
          title: Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(
                width: 8,
              ),
              Text(
                "Delhi",
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
          // leading: ,
        ),
        body: LazyLoadScrollView(
          onEndOfPage: _loadMoreStores,
          scrollOffset: 300,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                expandedHeight: (24 + 40 + 24 + 40 + 8).toDouble(),
                //8+40+8+40
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                collapsedHeight: (24 + 40 + 24 + 40 + 8).toDouble(),
                flexibleSpace: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 8),
                        child: SearchBar(
                          hintText: "Search for a store",
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    "Stores near you",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              BlocBuilder<StoreListBloc, StoreListState>(
                bloc: _storeListBloc,
                builder: (context, state) {
                  if (state is StoreListUninitialized) {
                    return SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  if (state is StoreListLoaded) {
                    stores = state.stores;
                    return SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext _, int index) {
                        final store = stores[index];
                        return StoreTile(
                          distance: store.distance!,
                          imageURL: store.thumbnail!,
                          rating: store.rating ?? "4.5",
                          storeName: store.name,
                          startingFrom: store.servicesStart!,
                          storeSlug: store.storeSlug!,
                        );
                      },
                      childCount: state.stores.length,
                    ));
                  }
                  if (state is StoreListError) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text("Failed to load"),
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
            ],
          ),
        ),
      ),
    );
  }

  void _loadMoreStores() {
    StoreListState currentState = _storeListBloc!.state;
    if (currentState is StoreListLoaded) {
      if (!currentState.hasReachedMax) {
        _pageIndex++;
        _storeListBloc!.add(LoadStoreListByCityPressed(
            offset: stores.length + 1, city: widget.city));
      }
    }
  }
}
