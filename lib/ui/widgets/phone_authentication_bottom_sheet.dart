import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/login/phone_login_screen.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils/utils.dart';

class PhoneAuthenticationBottomSheet extends StatefulWidget {
  final CartFunctionEvent event;
  final CartFunctionBloc cartBloc;
  final BuildContext ctx;
  const PhoneAuthenticationBottomSheet(
      {Key? key,
      required this.event,
      required this.cartBloc,
      required this.ctx})
      : super(key: key);

  @override
  _PhoneAuthenticationBottomSheetState createState() =>
      _PhoneAuthenticationBottomSheetState();
}

class _PhoneAuthenticationBottomSheetState
    extends State<PhoneAuthenticationBottomSheet> {
  late PhoneAuthBloc _phoneAuthBloc;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String otpEntered = '';
  late final FocusNode _phoneFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneFocusNode = FocusNode();
    _phoneFocusNode.requestFocus();
    _phoneAuthBloc = PhoneAuthBloc(
        repository: RepositoryProvider.of<AuthRepository>(context),
        globalAuthBloc: BlocProvider.of<GlobalAuthBloc>(context),
        localDataService: getIt.get<LocalDataService>(
            instanceName: LocalDataService.getItInstanceName),
        fcmInstance: FirebaseMessaging.instance);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
      bloc: _phoneAuthBloc,
      listener: (_, state) {
        if (state is FailedToSendOTP) {
          print("ok brother");
          Fluttertoast.showToast(
              msg: 'Failed to send OTP',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is OTPCheckFailed) {
          Fluttertoast.showToast(
              msg: 'OTP check failed',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);
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
            child: Center(child: loadingAnimation()),
            height: 30.h,
          );
        }
        if (state is CheckingOTP) {
          return Container(
            child: Center(child: loadingAnimation()),
            height: 30.h,
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizeConfig.kverticalMargin8,
          Text(
            'To continue further please sign in',
            style:
                SizeConfig.kStyle16W500.copyWith(fontWeight: FontWeight.w500),
          ),
          Divider(
            height: 32,
            thickness: 1,
          ),
          Text('Continue with number'),
          SizeConfig.kverticalMargin8,
          Form(
            child: PhoneTextField(
              phoneController: phoneController,
              // focusNode: _phoneFocusNode,
            ),
            key: _formKey,
          ),
          SizeConfig.kverticalMargin16,
          Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: Container(
                width: 100.w,
                height: 50,
                child: CommonTextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _phoneAuthBloc.add(
                          SendOTP(phoneNumber: '+91${phoneController.text}'));
                    }
                  },
                  backgroundColor: SizeConfig.kPrimaryColor,
                  buttonSemantics: 'Sent OTP Bottom Sheet',
                  child: Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              'A One-Time-Password has been sent your phone number',
              style: SizeConfig.kStyle12,
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.greenAccent),
          ),
          SizeConfig.kverticalMargin16,
          OTPFieldWidget(onChange: (string) {
            otpEntered = string;
            print('otp entered $otpEntered');
          }),
          SizeConfig.kverticalMargin16,
          Align(
            alignment: Alignment.center,
            child: SafeArea(
              child: Container(
                width: 100.w,
                height: 50,
                child: CommonTextButton(
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
                  backgroundColor: SizeConfig.kPrimaryColor,
                  buttonSemantics: 'Check OTP Bottom Sheet',
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
