import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/login/login_screen.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';

class AuthenticationBottomSheet extends StatefulWidget {
  final CartFunctionEvent event;
  final CartFunctionBloc cartBloc;
  const AuthenticationBottomSheet(
      {Key? key, required this.event, required this.cartBloc})
      : super(key: key);

  @override
  _AuthenticationBottomSheetState createState() =>
      _AuthenticationBottomSheetState();
}

class _AuthenticationBottomSheetState extends State<AuthenticationBottomSheet> {
  late PhoneAuthBloc _phoneAuthBloc;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String otpEntered = '';

  @override
  void initState() {
    super.initState();
    _phoneAuthBloc = PhoneAuthBloc(
        repository: RepositoryProvider.of<AuthRepository>(context),
        globalAuthBloc: BlocProvider.of<GlobalAuthBloc>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      bloc: _phoneAuthBloc,
      listener: (_, state) {
        if (state is FailedToSendOTP) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to send OTP. ${state.message}'),
          ));
        }
        if (state is OTPCheckFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('OTP check failed. ${state.message}'),
          ));
        }
        if (state is OTPCheckedPassed) {
          widget.cartBloc.add(widget.event);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is OTPSent || state is OTPCheckFailed) {
          return getEnterOTPWidget();
        }
        if (state is SendingOTP) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
            height: MediaQuery.of(context).size.height * .3,
          );
        }
        if (state is CheckingOTP) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
            height: MediaQuery.of(context).size.height * .3,
          );
        }
        if (state is FailedToSendOTP) {
          return getSendOTPWidget();
        }
        return getSendOTPWidget();
      },
    );
  }

  getSendOTPWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          kverticalMargin8,
          Text(
            'To continue further please sign in',
            style: kStyle16SemiBold.copyWith(fontWeight: FontWeight.w500),
          ),
          Divider(
            height: 32,
            thickness: 1,
          ),
          Text('Continue with number'),
          kverticalMargin8,
          PhoneTextField(phoneController: phoneController),
          kverticalMargin16,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  _phoneAuthBloc
                      .add(SendOTP(phoneNumber: '+91${phoneController.text}'));
                },
                child: Text(
                  'Send OTP',
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
          ),
        ],
      ),
    );
  }

  getEnterOTPWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              'A One-Time-Password has been sent your phone number',
              style: kStyle12,
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.greenAccent),
          ),
          kverticalMargin8,
          OTPFieldWidget(onChange: (string) {
            otpEntered = string;
            print('otp entered $otpEntered');
          }),
          kverticalMargin8,
          Align(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  print(otpEntered);
                  _phoneAuthBloc.add(CheckOTP(
                      otp: otpEntered,
                      phoneNumber: '+91${phoneController.text}'));
                },
                child: Text(
                  'Enter OTP',
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneAuthBloc.close();
  }
}
