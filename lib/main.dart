import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/data/api/api_constants.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/api/api_service.dart';
import 'package:themotorwash/data/local/local_auth_service.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';
import 'package:themotorwash/data/repos/auth_rest_repository.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/repos/payment_rest_repository.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/data/repos/rest_repository.dart';

import 'package:themotorwash/navigation/arguments.dart';

import 'package:themotorwash/simple_bloc_observer.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/cart/cart_function_bloc.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/home/home_screen.dart';
import 'package:themotorwash/ui/screens/login/login_screen.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/screens/slot_select/slot_select_screen.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_detail_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_reviews/store_reviews_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_services/store_services_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';

import 'package:get_it/get_it.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';
import 'package:themotorwash/ui/screens/your_bookings/bloc/your_bookings_bloc.dart';
import 'package:themotorwash/ui/screens/your_bookings/your_bookings_screen.dart';

GetIt getIt = GetIt.instance;

void main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Repository _repository;
  late PaymentRepository _paymentRepository;

  late AuthRepository _authRepository;

  late GlobalAuthBloc _globalAuthBloc;
  @override
  void initState() {
    super.initState();
    _globalAuthBloc = GlobalAuthBloc();
    _globalAuthBloc.add(AppStarted());

    getIt.registerSingleton<ApiMethods>(
        ApiService(apiConstants: ApiConstants(globalAuthBloc: _globalAuthBloc)),
        instanceName: 'ApiService');
    ApiMethods _apiMethodsImp =
        getIt.get<ApiMethods>(instanceName: 'ApiService');
    _repository = RestRepository(apiMethodsImp: _apiMethodsImp);
    _paymentRepository = PaymentRestRepository(apiMethodsImp: _apiMethodsImp);
    _authRepository = AuthRestRepository(apiMethodsImp: _apiMethodsImp);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalAuthBloc>(
          create: (_) => _globalAuthBloc,
        ),
        BlocProvider<StoreDetailBloc>(
            create: (_) => StoreDetailBloc(repository: _repository)),
        BlocProvider<StoreListBloc>(
          create: (_) => StoreListBloc(repository: _repository),
        ),
        BlocProvider<StoreReviewsBloc>(
          create: (_) => StoreReviewsBloc(repository: _repository),
        ),
        BlocProvider<CartFunctionBloc>(
          create: (_) => CartFunctionBloc(repository: _repository),
        ),
        BlocProvider<YourBookingsBloc>(
          create: (_) => YourBookingsBloc(repository: _repository),
        ),
        BlocProvider<PhoneAuthBloc>(
          create: (_) => PhoneAuthBloc(
              repository: _authRepository, globalAuthBloc: _globalAuthBloc),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => _authRepository),
          RepositoryProvider(create: (_) => _repository),
          RepositoryProvider(create: (_) => _paymentRepository),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              fontFamily: 'DM Sans',
              scaffoldBackgroundColor: Colors.white),
          home: FutureBuilder<AuthTokensModel>(
              future: LocalAuthService().getAuthTokens(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.authenticated) {
                      // return BookingSummaryScreen(bookingId: '546F12');
                      return ProfileScreen();
                    } else {
                      return ProfileScreen();
                    }
                  }
                }
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
          //  BlocBuilder<GlobalAuthBloc, GlobalAuthState>(
          //   bloc: _globalAuthBloc,
          //   builder: (context, state) {
          //     if (state is Authenticated) {
          //       return HomeScreen();
          //     }
          //     if (state is Unauthenticated) {
          //       return HomeScreen();
          //     }

          // return Scaffold(
          //   body: Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
          //   },
          // ),
          onGenerateRoute: (settings) {
            if (settings.name == StoreListScreen.route) {
              final args = settings.arguments as StoreListArguments;

              return MaterialPageRoute(
                builder: (context) {
                  return StoreListScreen(city: args.city);
                },
              );
            }
            if (settings.name == HomeScreen.route) {
              return MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
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
              final args = settings.arguments as SlotSelectScreenArguments;

              return MaterialPageRoute(
                builder: (context) {
                  return SlotSelectScreen(
                    cartTotal: args.cartTotal,
                    cartId: args.cardId,
                  );
                },
              );
            }
            if (settings.name == BookingSummaryScreen.route) {
              final args = settings.arguments as BookingSummaryScreenArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return BookingSummaryScreen(bookingId: args.bookingId);
                },
              );
            }
            if (settings.name == LoginScreen.route) {
              return MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              );
            }
            if (settings.name == VerifyPhoneScreen.route) {
              final args = settings.arguments as VerifyPhoneScreenArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return VerifyPhoneScreen(phoneNumber: args.phoneNumber);
                },
              );
            }
            assert(false, 'Need to implement ${settings.name}');
          },
        ),
      ),
    );
  }
}
