import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/blocs/global_vehicle_type/bloc/global_vehicle_type_bloc.dart';
import 'package:themotorwash/blocs/location_functions/bloc/location_functions_bloc.dart';
import 'package:themotorwash/blocs/order_review/order_review_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/data/api/api_constants.dart';
import 'package:themotorwash/data/api/api_methods.dart';
import 'package:themotorwash/data/api/api_service.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/models/auth_tokens.dart';
import 'package:themotorwash/data/notifications/fcm_helper.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';
import 'package:themotorwash/data/repos/auth_rest_repository.dart';
import 'package:themotorwash/data/repos/payment_repository.dart';
import 'package:themotorwash/data/repos/payment_rest_repository.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/data/repos/rest_repository.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/simple_bloc_observer.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/booking_detail/booking_detail.dart';
import 'package:themotorwash/ui/screens/booking_summary/booking_summary_screen.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/feedback/feedback_screen.dart';
import 'package:themotorwash/ui/screens/home/home_screen.dart';
import 'package:themotorwash/ui/screens/login/login_screen.dart';
import 'package:themotorwash/ui/screens/order_review/order_review.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/screens/slot_select/slot_select_screen.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_detail_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/blocs/store_reviews/store_reviews_bloc.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/store_list/bloc/store_list_bloc.dart';
import 'package:themotorwash/ui/screens/store_list/store_list_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';
import 'package:themotorwash/ui/screens/your_bookings/bloc/your_bookings_bloc.dart';
import 'package:themotorwash/ui/screens/your_bookings/your_bookings_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

GetIt getIt = GetIt.instance;

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  try {
    await Firebase.initializeApp();
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    //TODO : Implement FCM and Local Notification for iOS
    channel = const AndroidNotificationChannel(
      'default_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
      playSound: true,

      sound: RawResourceAndroidNotificationSound('turbo'),
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // await FirebaseMessaging.instance.subscribeToTopic('hello');

    await Hive.initFlutter();
  } on Exception catch (e) {
    print(e.toString());
  }
  Bloc.observer = SimpleBlocObserver();

  runApp(
    MyApp(),
    // Wrap your app
  );
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
  late GlobalLocationBloc _globalLocationBloc;
  late GlobalVehicleTypeBloc _globalVehicleTypeBloc;
  late OrderReviewBloc _orderReviewBloc;
  late CartFunctionBloc _cartFunctionBloc;
  late LocalDataService _localDataService;
  late FirebaseMessaging _fcmInstance;

  @override
  void initState() {
    super.initState();
    precacheImage(AssetImage('assets/images/splash_background.png'), context);
    FcmHelper().onMessageFCM();
    _fcmInstance = FirebaseMessaging.instance;
    _globalAuthBloc = GlobalAuthBloc();
    _globalAuthBloc.add(AppStarted());
    getIt.registerSingleton<ApiMethods>(
        ApiService(apiConstants: ApiConstants(globalAuthBloc: _globalAuthBloc)),
        instanceName: ApiService.getItInstanceName);
    getIt.registerSingleton<LocalDataService>(LocalDataService(),
        instanceName: LocalDataService.getItInstanceName);
    ApiMethods _apiMethodsImp =
        getIt.get<ApiMethods>(instanceName: 'ApiService');
    _localDataService = getIt.get<LocalDataService>(
        instanceName: LocalDataService.getItInstanceName);

    _globalVehicleTypeBloc =
        GlobalVehicleTypeBloc(localDataService: _localDataService);

    _globalVehicleTypeBloc.add(CheckSavedVehicleType());
    _repository = RestRepository(apiMethodsImp: _apiMethodsImp);
    _paymentRepository = PaymentRestRepository(apiMethodsImp: _apiMethodsImp);
    _authRepository = AuthRestRepository(apiMethodsImp: _apiMethodsImp);
    _orderReviewBloc = OrderReviewBloc();
    _globalLocationBloc = GlobalLocationBloc(repository: _repository);

    _cartFunctionBloc = CartFunctionBloc(
        repository: _repository, orderReviewBloc: _orderReviewBloc);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalAuthBloc>(
          create: (_) => _globalAuthBloc,
        ),
        BlocProvider<StoreDetailBloc>(
            create: (_) => StoreDetailBloc(repository: _repository)),
        BlocProvider<StoreListBloc>(
          create: (_) => StoreListBloc(
              repository: _repository, globalLocationBloc: _globalLocationBloc),
        ),
        BlocProvider<StoreReviewsBloc>(
          create: (_) => StoreReviewsBloc(repository: _repository),
        ),
        BlocProvider<CartFunctionBloc>(
          create: (_) => _cartFunctionBloc,
        ),
        BlocProvider<YourBookingsBloc>(
          create: (_) => YourBookingsBloc(repository: _repository),
        ),
        BlocProvider<PhoneAuthBloc>(
          create: (_) => PhoneAuthBloc(
              repository: _authRepository,
              globalAuthBloc: _globalAuthBloc,
              fcmInstance: _fcmInstance,
              localDataService: _localDataService),
        ),
        BlocProvider<GlobalLocationBloc>(
          create: (_) => _globalLocationBloc,
        ),
        BlocProvider<GlobalVehicleTypeBloc>(
          create: (_) => _globalVehicleTypeBloc,
        ),
        BlocProvider<OrderReviewBloc>(
          create: (_) => _orderReviewBloc,
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (_) => _authRepository),
          RepositoryProvider(create: (_) => _repository),
          RepositoryProvider(create: (_) => _paymentRepository),
        ],
        child: MaterialApp(
          // builder: DevicePreview.appBuilder, // Add the locale here
          builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget!),
              maxWidth: 1200,
              minWidth: 450,
              defaultScale: true,
              // mediaQueryData: MediaQueryData(textScaleFactor: 1),
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: Color(0xFFF5F5F5))),

          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarBrightness: Brightness.dark),
              ),
              primaryColor: kPrimaryColor,
              fontFamily: 'DM Sans',
              scaffoldBackgroundColor: Colors.white),
          home: FutureBuilder<AuthTokensModel>(
              future: LocalDataService().getAuthTokens(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.authenticated) {
                      // return BookingSummaryScreen(bookingId: '8D6D98');
                      return ExploreScreen();
                    } else {
                      return LoginScreen();
                    }
                  }
                }
                return Scaffold(
                  body: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/splash_background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Builder(builder: (ctx) {
                        return Image.asset(
                          'assets/images/logo.png',
                          scale: 4,
                        );
                      }),
                    ),
                  ),
                );
              }),
          onGenerateRoute: (settings) {
            if (settings.name == StoreListScreen.route) {
              final args = settings.arguments as StoreListArguments;

              return MaterialPageRoute(
                builder: (context) {
                  return StoreListScreen(
                    city: args.city,
                    title: args.title,
                  );
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
                  return BookingSummaryScreen(
                    bookingId: args.bookingId,
                    isTransactionSuccessful: args.isTransactionSuccesful,
                  );
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
            if (settings.name == ProfileScreen.route) {
              final args = settings.arguments as ProfileScreenArguments;

              return MaterialPageRoute(
                builder: (context) {
                  return ProfileScreen(
                    showSkip: args.showSkip,
                  );
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
            if (settings.name == ExploreScreen.route) {
              return MaterialPageRoute(
                builder: (context) {
                  return ExploreScreen();
                },
              );
            }
            if (settings.name == OrderReviewScreen.route) {
              final args = settings.arguments as OrderReviewScreenArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return OrderReviewScreen(
                    dateSelected: args.dateSelected,
                  );
                },
              );
            }
            if (settings.name == YourBookingsScreen.route) {
              return MaterialPageRoute(
                builder: (context) {
                  return YourBookingsScreen();
                },
              );
            }

            if (settings.name == BookingDetailScreen.route) {
              final args = settings.arguments as BookingDetailScreenArguments;

              return MaterialPageRoute(
                builder: (context) {
                  return BookingDetailScreen(
                      status: args.status, bookingId: args.bookingId);
                },
              );
            }
            if (settings.name == FeedbackScreen.route) {
              final args = settings.arguments as FeedbackScreenArguments;
              return MaterialPageRoute(
                builder: (context) {
                  return FeedbackScreen(
                    isFeedback: args.isFeedback,
                    orderNumber: args.orderNumber,
                  );
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
// TODO : Implement Vehicle type ui with bloc
// TODO : Implement search services bloc with ui  and apis
// TODO : Implement search stores bloc with ui  and apis
// TODO :
// TODO : remove ! force check
// TODO : create home screen blocs, integrate them with ui
