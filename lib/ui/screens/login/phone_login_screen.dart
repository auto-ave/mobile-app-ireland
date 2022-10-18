import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';
import 'package:themotorwash/ui/widgets/fade_slide_transition.dart';
import 'package:themotorwash/utils/utils.dart';

class PhoneLoginScreen extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;

  static final String route = '/loginScreen';
  const PhoneLoginScreen({Key? key, required this.initialLink})
      : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Duration kLoginAnimationDuration = Duration(milliseconds: 800);

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
    if (widget.initialLink != null) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        if (widget.initialLink?.link?.queryParameters['store'] != null) {
          final slug =
              widget.initialLink?.link?.queryParameters['store'] as String;
          autoaveLog('slug $slug');
          Navigator.pushNamed(context, StoreDetailScreen.route,
              arguments: StoreDetailArguments(storeSlug: slug));
        }
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlutterUxcam.tagScreenName(PhoneLoginScreen.route);
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarIconBrightness: Brightness.light));
    return Scaffold(
      appBar: AppBarLoginScreen(),
      backgroundColor: Colors.white,
      body:
          //  Stack(
          //   children: [
          Column(
        children: [
          Expanded(
            child: FadeSlideTransition(
              animation: _formElementAnimation,
              additionalOffset: 0,
              child: Lottie.asset('assets/animations/login_car.json'),
              // Image.asset(
              //   'assets/images/oreti.png',
              //   width: 100.w,
              //   fit: BoxFit.fitWidth,
              // ),
            ),
          ),
          FadeSlideTransition(
              animation: _formElementAnimation,
              additionalOffset: 0,
              child: Container(
                child: LoginBottom(
                  animation: _formElementAnimation,
                ),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 16,
                          offset: Offset(0, -8),
                          color: Color.fromRGBO(105, 105, 105, 0.16))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5))),
              )),
        ],
      ),
      // Positioned(
      //   top: 0,
      //   child: SizedBox(
      //     width: MediaQuery.of(context).size.width,
      //     child: Row(
      //       children: [
      //         Image.asset(
      //           'assets/images/logo.png',
      //           width: MediaQuery.of(context).size.width * .3,
      //         ),
      //         Spacer(),
      //         Text(
      //           'skip',
      //           style: SizeConfig.kStyle16PrimaryColor,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      //   ],
      // ),
    );
  }
}

class LoginBottom extends StatefulWidget {
  final Animation<double> animation;
  const LoginBottom({Key? key, required this.animation}) : super(key: key);

  @override
  _LoginBottomState createState() => _LoginBottomState();
}

class _LoginBottomState extends State<LoginBottom> with WidgetsBindingObserver {
  late PhoneAuthBloc phoneAuthBloc;

  final phoneController = TextEditingController();
  late final Animation<double> _animation;
  // late final FocusNode _phoneFocusNode;
  @override
  void initState() {
    super.initState();
    phoneAuthBloc = BlocProvider.of<PhoneAuthBloc>(context);
    // _phoneFocusNode = FocusNode();

    _animation = widget.animation;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizeConfig.kverticalMargin16,
            FadeSlideTransition(
              animation: _animation,
              additionalOffset: 0.0,
              child: Text(
                'Lets get you started',
                style: SizeConfig.kStyle20Bold,
              ),
            ),
            SizeConfig.kverticalMargin16,
            BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
              bloc: phoneAuthBloc,
              listener: (_, state) {
                if (state is SendingOTP) {
                  showSnackbar(context, 'Sending OTP to your phone');
                }
                if (state is FailedToSendOTP) {
                  showSnackbar(context, 'Failed to send OTP');
                }
                if (state is OTPSent) {
                  showSnackbar(context, 'OTP sent');
                  print('heloz');
                  Navigator.pushNamedAndRemoveUntil(
                      context, VerifyPhoneScreen.route, (route) => false,
                      arguments: VerifyPhoneScreenArguments(
                          phoneNumber: "+91" + phoneController.text));
                }
              },
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeSlideTransition(
                          animation: _animation,
                          additionalOffset: 16 * 1,
                          child: Text(
                            'Enter your phone number',
                            style: SizeConfig.kStyle14W500
                                .copyWith(fontWeight: FontWeight.normal),
                          )),
                      SizeConfig.kverticalMargin8,
                      FadeSlideTransition(
                          animation: _animation,
                          additionalOffset: 16 * 2,
                          child: PhoneTextField(
                            phoneController: phoneController,
                            // focusNode: _phoneFocusNode,
                          )),
                      SizeConfig.kverticalMargin16,
                      FadeSlideTransition(
                          animation: _animation,
                          additionalOffset: 16 * 3,
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 100.w,
                              height: 50,
                              child: TextButton(
                                onPressed: state is SendingOTP
                                    ? () {}
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          phoneAuthBloc.add(SendOTP(
                                              phoneNumber: "+91" +
                                                  phoneController.text));
                                        }
                                      },
                                child: Text(
                                  'Send OTP',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      state is SendingOTP
                                          ? Colors.grey
                                          : SizeConfig.kPrimaryColor),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizeConfig.kverticalMargin16,
                    ],
                  ),
                );
              },
            )
          ],
        ));
  }
}

class PhoneTextField extends StatelessWidget {
  final TextEditingController phoneController;
  // final FocusNode focusNode;
  const PhoneTextField({
    Key? key,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatePhone,
      controller: phoneController,
      keyboardType: TextInputType.phone,
      autofocus: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: SizeConfig.kPrimaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: SizeConfig.kPrimaryColor)),
        prefixIcon: SizedBox(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizeConfig.kHorizontalMargin16,
              Text('+91', style: SizeConfig.kStyle14W500),
              SizeConfig.kHorizontalMargin8,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: VerticalDivider(
                  thickness: 1.5,
                ),
              ),
            ],
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SizeConfig.kPrimaryColor),
        ),
      ),
    );
  }
}
