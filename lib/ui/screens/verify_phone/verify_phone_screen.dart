import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/home/home_screen.dart';
import 'package:themotorwash/ui/screens/login/login_screen.dart';
import 'package:themotorwash/utils.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({Key? key, required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;

  static final String route = '/verifyPhoneScreen';

  @override
  _VerifyPhoneScreenState createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  late PhoneAuthBloc phoneAuthBloc;
  String enteredOtp = "";

  @override
  void initState() {
    super.initState();
    phoneAuthBloc = BlocProvider.of<PhoneAuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: getAppBarLoginScreen(context: context),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocListener<GlobalAuthBloc, GlobalAuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  Navigator.pushNamedAndRemoveUntil(
                      context, ExploreScreen.route, (route) => false);
                }
              },
              child: BlocListener<PhoneAuthBloc, PhoneAuthState>(
                bloc: phoneAuthBloc,
                listener: (_, state) {
                  if (state is SendingOTP) {
                    showSnackbar(context, 'Resending OTP...');
                  }
                  if (state is FailedToSendOTP) {
                    showSnackbar(context, 'Failed to send OTP.');
                  }
                  if (state is OTPSent) {
                    showSnackbar(context, 'OTP Sent..');
                  }
                  if (state is CheckingOTP) {
                    // showSnackbar(context, 'Verifying OTP..');
                  }
                  if (state is OTPCheckedPassed) {}

                  if (state is OTPCheckFailed) {
                    showSnackbar(context, 'Wrong OTP entered');
                  }
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('An OTP is sent to ${widget.phoneNumber}',
                                style: SizeConfig.kStyle16W500
                                    .copyWith(fontWeight: FontWeight.normal)),
                            SizeConfig.kverticalMargin16,
                            Text.rich(
                              TextSpan(
                                  text: 'Not your number? ',
                                  style: SizeConfig.kStyle12
                                      .copyWith(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                LoginScreen.route,
                                                (route) => false),
                                      text: 'Change number',
                                      style: SizeConfig.kStyle12PrimaryColor
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                    )
                                  ]),
                            ),
                            SizeConfig.kverticalMargin16,
                            OTPFieldWidget(onChange: onChanged),
                            SizeConfig.kverticalMargin16,
                            Text.rich(
                              TextSpan(
                                  text: 'Didn’t recive a Code? ',
                                  style: SizeConfig.kStyle12
                                      .copyWith(color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: 'Request again',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => phoneAuthBloc.add(
                                              SendOTP(
                                                  phoneNumber:
                                                      widget.phoneNumber)),
                                        style: SizeConfig.kStyle12PrimaryColor
                                            .copyWith(
                                                decoration:
                                                    TextDecoration.underline))
                                  ]),
                            ),
                            SizeConfig.kverticalMargin16,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: BlocBuilder<PhoneAuthBloc, PhoneAuthState>(
                        bloc: phoneAuthBloc,
                        builder: (context, state) {
                          return TextButton(
                            onPressed: enteredOtp.length == 4 &&
                                    !(state is CheckingOTP)
                                ? () {
                                    phoneAuthBloc.add(CheckOTP(
                                        otp: enteredOtp,
                                        phoneNumber: widget.phoneNumber));
                                  }
                                : null,
                            child: Text(
                              'Verify',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  enteredOtp.length == 4 &&
                                          !(state is CheckingOTP)
                                      ? SizeConfig.kPrimaryColor
                                      : Colors.grey),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizeConfig.kverticalMargin32
                  ],
                ),
              ),
            ),
          )),
    );
  }

  onChanged(String pin) {
    setState(() {
      enteredOtp = pin;
    });
  }
}

class OTPFieldWidget extends StatelessWidget {
  final Function(String) onChange;
  const OTPFieldWidget({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      onChanged: onChange,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.center,
      pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(4),
          fieldHeight: 50,
          borderWidth: 1,
          shape: PinCodeFieldShape.box,
          activeColor: SizeConfig.kPrimaryColor,
          disabledColor: SizeConfig.kPrimaryColor,
          selectedColor: SizeConfig.kPrimaryColor,
          inactiveColor: SizeConfig.kPrimaryColor),
    );
  }
}
