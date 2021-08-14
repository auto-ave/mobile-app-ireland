import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
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
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocListener<PhoneAuthBloc, PhoneAuthState>(
          bloc: phoneAuthBloc,
          listener: (_, state) {
            if (state is SendingOTP) {
              showSnackbar(context, 'Sending OTP...');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Sending OTP...'),
                duration: Duration(seconds: 1),
              ));
            }
            if (state is FailedToSendOTP) {
              showSnackbar(context, 'Failed to send OTP. ${state.message}');
            }
            if (state is OTPSent) {
              showSnackbar(context, 'OTP Sent..');
            }
            if (state is CheckingOTP) {
              showSnackbar(context, 'Verifying OTP..');
            }
            if (state is OTPCheckedPassed) {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.route, (route) => false);
            }
          },
          child: Column(
            children: [
              kverticalMargin32,
              Text('An OTP is sent to ${widget.phoneNumber}',
                  style:
                      kStyle16SemiBold.copyWith(fontWeight: FontWeight.normal)),
              kverticalMargin16,
              RichText(
                text: TextSpan(
                    text: 'Not your number? ',
                    style: kStyle12.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.route, (route) => false),
                        text: 'Change number',
                        style: kStyle12PrimaryColor.copyWith(
                            decoration: TextDecoration.underline),
                      )
                    ]),
              ),
              kverticalMargin16,
              OTPFieldWidget(onChange: onChanged),
              kverticalMargin16,
              RichText(
                text: TextSpan(
                    text: 'Didn’t recive a Code? ',
                    style: kStyle12.copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                          text: 'Request again',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => phoneAuthBloc
                                .add(SendOTP(phoneNumber: widget.phoneNumber)),
                          style: kStyle12PrimaryColor.copyWith(
                              decoration: TextDecoration.underline))
                    ]),
              ),
              kverticalMargin16,
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    phoneAuthBloc.add(CheckOTP(
                        otp: enteredOtp, phoneNumber: widget.phoneNumber));
                  },
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  onChanged(String pin) {
    enteredOtp = pin;
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
      mainAxisAlignment: MainAxisAlignment.center,
      pinTheme: PinTheme(
          fieldOuterPadding: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(4),
          fieldHeight: 50,
          borderWidth: 1,
          shape: PinCodeFieldShape.box,
          activeColor: kPrimaryColor,
          disabledColor: kPrimaryColor,
          selectedColor: kPrimaryColor,
          inactiveColor: kPrimaryColor),
    );
  }
}
