import 'dart:math';

import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/login/login_screen.dart';
import 'package:themotorwash/ui/screens/onboarding/components/app_bar.dart';
import 'package:themotorwash/ui/screens/onboarding/components/next_page_button.dart';
import 'package:themotorwash/ui/screens/onboarding/components/onboard_header.dart';
import 'package:themotorwash/ui/screens/onboarding/components/onboarding_page_indicator.dart';
import 'package:themotorwash/ui/screens/onboarding/components/pages/booking_confirmed_onboard.dart';
import 'package:themotorwash/ui/screens/onboarding/components/pages/select_service_onboard.dart';
import 'package:themotorwash/ui/screens/onboarding/components/pages/select_slot_onboard.dart';
import 'package:themotorwash/ui/screens/onboarding/components/pages/select_store_onboard.dart';
import 'package:themotorwash/ui/screens/onboarding/components/ripple.dart';
import 'package:themotorwash/utils/utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late Animation<double> _rippleAnimation;
  int _currentPage = 0;
  late Animation<double> _pageIndicatorAnimation;
  late final AnimationController _pageIndicatorAnimationController;
  late final AnimationController _rippleAnimationController;
  Duration kButtonAnimationDuration = Duration(milliseconds: 600);
  Duration kCardAnimationDuration = Duration(milliseconds: 400);
  Duration kRippleAnimationDuration = Duration(milliseconds: 400);
  Duration kLoginAnimationDuration = Duration(milliseconds: 1500);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _cardsAnimationController = AnimationController(
    //   vsync: this,
    //   duration: kCardAnimationDuration,
    // );
    _pageIndicatorAnimationController = AnimationController(
      vsync: this,
      duration: kButtonAnimationDuration,
    );
    _rippleAnimationController = AnimationController(
      vsync: this,
      duration: kRippleAnimationDuration,
    );

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 100.h,
    ).animate(CurvedAnimation(
      parent: _rippleAnimationController,
      curve: Curves.fastOutSlowIn,
    ));

    _setPageIndicatorAnimation();
    // _setCardsSlideOutAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarOnboardingScreen(),
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   // leading: IconButton(
      //   //   icon: Icon(
      //   //     Icons.arrow_back_ios,
      //   //     color: Colors.black,
      //   //   ),
      //   //   onPressed: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   // ),
      // ),
      body: Builder(builder: (ctx) {
        SizeConfig().init(ctx);
        return Stack(
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Header(onSkip: _goToLogin),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: Text(
                    //     'Steps to get your car washed',
                    //     style: SizeConfig.kStyle24Bold,
                    //   ),
                    // ),

                    SizeConfig.kverticalMargin32,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: OnboardHeader(
                        currentIndex: _currentPage,
                        headers: [
                          OnboardHeaderModel(
                              title: 'Choose from a variety of stores',
                              subtitle:
                                  'Compare Images, Prices, Ratings and Reviews to find the best store according to your needs.'),
                          OnboardHeaderModel(
                              title: 'Explore services',
                              subtitle:
                                  'Select your desired services and apply exciting offers to get upto 15% off on all services.'),
                          OnboardHeaderModel(
                              title: 'Get time slots',
                              subtitle:
                                  'No more waiting in queues, pre-book a slot according to your schedule.'),
                          OnboardHeaderModel(
                              title: 'Booking in 3 simple steps',
                              subtitle:
                                  'After your slot is booked, reach the store at the selected time slot and get your service without any wait.'),
                          // OnboardHeaderModel(
                          //     title: 'Booking Complete!',
                          //     subtitle:
                          //         'Voila! Your slot is now booked, reach the store at the selected time slot and get your service without any wait.'),
                        ],
                      ),
                    ),
                    SizeConfig.kverticalMargin8,
                    Flexible(child: Center(child: _getPage())),
                    SizeConfig.kverticalMargin8,
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedBuilder(
                        animation: _pageIndicatorAnimation,
                        builder: (_, Widget? child) {
                          return OnboardingPageIndicator(
                            angle: _pageIndicatorAnimation.value,
                            currentPage: _currentPage,
                            child: child!,
                          );
                        },
                        child: NextPageButton(
                          onPressed: _nextPage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _rippleAnimation,
              builder: (_, Widget? child) {
                return Ripple(radius: _rippleAnimation.value);
              },
            ),
          ],
        );
      }),
    );
  }

  void _setPageIndicatorAnimation({bool isClockwiseAnimation = true}) {
    final multiplicator = isClockwiseAnimation ? 2 : -2;
    // _pageIndicatorAnimationController.addStatusListener((status) {
    //   autoaveLog('Helll' + status.toString());
    // });
    setState(() {
      _pageIndicatorAnimation = Tween(
        begin: 0.0,
        end: multiplicator * pi,
      ).animate(
        CurvedAnimation(
          parent: _pageIndicatorAnimationController,
          curve: Curves.easeIn,
        ),
      );
      // _pageIndicatorAnimationController.reset();
    });
  }

  Widget _getPage() {
    switch (_currentPage) {
      case 0:
        return SelectStoreOnboardPage();
      case 1:
        return SelectServiceOnboardPage();
      case 2:
        return SelectSlotOnboardPage();
      case 3:
        return BookingConfirmedOnboardPage();

      default:
        return Container();
    }
  }

  Future<void> _nextPage() async {
    autoaveLog('Next Page Called $_currentPage');
    switch (_currentPage) {
      case 0:
        if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
          autoaveLog('Reached case 0');
          _pageIndicatorAnimationController.reset();
          _pageIndicatorAnimationController.forward();
          // await _cardsAnimationController.forward();
          _setNextPage(1);
          // _setCardsSlideInAnimation();
          // await _cardsAnimationController.forward();
          // _setCardsSlideOutAnimation();
          _setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 1:
        if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
          autoaveLog('Reached case 1');
          _pageIndicatorAnimationController.reset();
          _pageIndicatorAnimationController.forward();
          // await _cardsAnimationController.forward();
          _setNextPage(2);
          // _setCardsSlideInAnimation();
          // await _cardsAnimationController.forward();
          // _setCardsSlideOutAnimation();
          _setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 2:
        if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
          autoaveLog('Reached case 2');
          _pageIndicatorAnimationController.reset();
          _pageIndicatorAnimationController.forward();
          // await _cardsAnimationController.forward();
          _setNextPage(3);
          // _setCardsSlideInAnimation();
          // await _cardsAnimationController.forward();
          // _setPageIndicatorAnimation(isClockwiseAnimation: false);
        }
        break;
      case 3:
        // if (_pageIndicatorAnimation.status == AnimationStatus.dismissed) {
        //   autoaveLog('Reached case 3');
        //   _pageIndicatorAnimationController.forward();
        //   // await _cardsAnimationController.forward();
        //   _setNextPage(4);
        //   // _setCardsSlideInAnimation();
        //   // await _cardsAnimationController.forward();
        // }
        if (_pageIndicatorAnimation.status == AnimationStatus.completed) {
          autoaveLog('Reached case 4');
          await _goToLogin();
        }
        break;
      // case 4:

      //   break;
    }
  }

  @override
  void dispose() {
    _pageIndicatorAnimationController.dispose();
    _rippleAnimationController.dispose();
    super.dispose();
  }

  Future<void> _goToLogin() async {
    await _rippleAnimationController.forward();
    Navigator.of(context).pushNamed(LoginScreen.route);
  }

  void _setNextPage(int nextPageNumber) {
    setState(() {
      _currentPage = nextPageNumber;
    });
  }
}
