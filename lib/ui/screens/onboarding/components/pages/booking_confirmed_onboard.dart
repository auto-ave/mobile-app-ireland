import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/widgets/fade_slide_transition.dart';

class BookingConfirmedOnboardPage extends StatefulWidget {
  const BookingConfirmedOnboardPage({Key? key}) : super(key: key);

  @override
  State<BookingConfirmedOnboardPage> createState() =>
      _BookingConfirmedOnboardPageState();
}

class _BookingConfirmedOnboardPageState
    extends State<BookingConfirmedOnboardPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Duration kLoginAnimationDuration = Duration(milliseconds: 500);

  late final Animation<double> _formElementAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: kLoginAnimationDuration,
    );
    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);
    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeSlideTransition(
      animation: _formElementAnimation,
      additionalOffset: 0,
      child:
          // SizeConfig.kverticalMargin32,
          Image.asset(
        'assets/images/onboarding/booking_confirmed/bc.png',
        scale: 2,
      ),
    );
  }
}
