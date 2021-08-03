import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/data/api/api_constants.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/api/api_service.dart';
import 'package:themotorwash/data/repository.dart';
import 'package:themotorwash/data/rest_repository.dart';
import 'package:themotorwash/navigation/arguments.dart';

import 'package:themotorwash/simple_bloc_observer.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/cart/cart_function_bloc.dart';
import 'package:themotorwash/ui/screens/home/home_screen.dart';
import 'package:themotorwash/ui/screens/slot_select/slot_select_screen.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_detail_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_reviews/store_reviews_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_services/store_services_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';

import 'package:get_it/get_it.dart';
import 'package:themotorwash/ui/screens/your_bookings/bloc/your_bookings_bloc.dart';
import 'package:themotorwash/ui/screens/your_bookings/your_bookings_screen.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerSingleton<ApiMethods>(ApiService(apiConstants: ApiConstants()),
      instanceName: 'ApiService');
}

void main() async {
  setupLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Repository _repository = RestRepository(
      apiMethodsImp: getIt.get<ApiMethods>(instanceName: 'ApiService'));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoreDetailBloc>(
            create: (_) => StoreDetailBloc(repository: _repository)),
        BlocProvider<StoreListBloc>(
          create: (_) => StoreListBloc(repository: _repository),
        ),
        BlocProvider<StoreReviewsBloc>(
          create: (_) => StoreReviewsBloc(repository: _repository),
        ),
        BlocProvider<StoreServicesBloc>(
          create: (_) => StoreServicesBloc(repository: _repository),
        ),
        BlocProvider<CartFunctionBloc>(
          create: (_) => CartFunctionBloc(repository: _repository),
        ),
        BlocProvider<YourBookingsBloc>(
          create: (_) => YourBookingsBloc(repository: _repository),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: kPrimaryColor, fontFamily: 'DM Sans'),
        home: YourBookingsScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == StoreListScreen.route) {
            final args = settings.arguments as StoreListArguments;

            return MaterialPageRoute(
              builder: (context) {
                return StoreListScreen(city: args.city);
              },
            );
          }
          if (settings.name == StoreDetailScreen.route) {
            final args = settings.arguments as StoreDetailArguments;
            return MaterialPageRoute(
              builder: (context) {
                return StoreDetailScreen(
                  storeSlug: args.storeSlug,
                );
              },
            );
          }
          if (settings.name == SlotSelectScreen.route) {
            return MaterialPageRoute(
              builder: (context) {
                return SlotSelectScreen();
              },
            );
          }
          assert(false, 'Need to implement ${settings.name}');
        },
      ),
    );
  }
}
