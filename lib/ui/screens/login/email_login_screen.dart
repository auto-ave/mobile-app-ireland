import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import 'package:themotorwash/blocs/email_auth/bloc/email_auth_bloc.dart';

import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/screens/store_detail/store_detail_screen.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';
import 'package:themotorwash/ui/widgets/fade_slide_transition.dart';
import 'package:themotorwash/utils/utils.dart';

class EmailLoginScreen extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;

  static final String route = '/emailLoginScreen';
  const EmailLoginScreen({Key? key, required this.initialLink})
      : super(key: key);

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen>
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
    FlutterUxcam.tagScreenName(EmailLoginScreen.route);
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
                child: EmailLoginBottom(
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

class EmailLoginBottom extends StatefulWidget {
  final Animation<double> animation;
  const EmailLoginBottom({Key? key, required this.animation}) : super(key: key);

  @override
  _EmailLoginBottomState createState() => _EmailLoginBottomState();
}

class _EmailLoginBottomState extends State<EmailLoginBottom>
    with WidgetsBindingObserver {
  late EmailAuthBloc emailAuthBloc;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  late final Animation<double> _animation;
  // late final FocusNode _phoneFocusNode;
  @override
  void initState() {
    super.initState();
    emailAuthBloc = BlocProvider.of<EmailAuthBloc>(context);
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
            BlocConsumer<EmailAuthBloc, EmailAuthState>(
              bloc: emailAuthBloc,
              listener: (_, state) {
                if (state is EmailAuthError) {
                  showSnackbar(context, 'Something went wrong.');
                }

                if (state is EmailAuthenticated) {
                  // showSnackbar(context, 'OTP sent');
                  // print('heloz');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    ExploreScreen.route,
                    (route) => false,
                  );
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
                          additionalOffset: 16 * 2,
                          child: CommonTextField(
                            autoFocus: true,
                            fieldController: nameController,
                            validator: (value) {
                              if (value != null) {
                                if (value.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter a valid name';
                                }
                              } else {
                                return 'Enter a valid name';
                              }
                            },
                            // isEmail: false,
                            hintText: 'Name',
                            filled: false,
                            keyboardType: TextInputType.name,
                            // focusNode: _phoneFocusNode,
                          )),
                      SizeConfig.kverticalMargin16,
                      FadeSlideTransition(
                          animation: _animation,
                          additionalOffset: 16 * 2,
                          child: CommonTextField(
                            keyboardType: TextInputType.emailAddress,
                            fieldController: emailController,
                            validator: validateEmail,
                            hintText: 'Email',
                            filled: false,
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
                                onPressed: state is EmailAuthLoading
                                    ? () {}
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          emailAuthBloc.add(
                                              AuthenticateEmailAndName(
                                                  email: emailController.text,
                                                  firstName:
                                                      nameController.text,
                                                  lastName: ' a'));
                                        }
                                      },
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      state is EmailAuthLoading
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

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEmail;
  final String hintText;

  // final FocusNode focusNode;
  const LoginTextField({
    Key? key,
    required this.controller,
    required this.isEmail,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: isEmail
          ? validateEmail
          : (value) {
              if (value != null) {
                if (value.isNotEmpty) {
                  return null;
                } else {
                  return 'Enter a valid name';
                }
              } else {
                return 'Enter a valid name';
              }
            },
      controller: controller,
      keyboardType: TextInputType.phone,
      autofocus: true,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: SizeConfig.kPrimaryColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: SizeConfig.kPrimaryColor)),
        // prefixIcon: SizedBox(
        //   height: 50,
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       SizeConfig.kHorizontalMargin16,
        //       Text('+91', style: SizeConfig.kStyle14W500),
        //       SizeConfig.kHorizontalMargin8,
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 8.0),
        //         child: VerticalDivider(
        //           thickness: 1.5,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: SizeConfig.kPrimaryColor),
        ),
      ),
    );
  }
}
