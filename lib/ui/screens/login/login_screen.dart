import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';

class LoginScreen extends StatelessWidget {
  static final String route = '/loginScreen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Flexible(
              child: Image.asset(
                'assets/images/oreti.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              child: LoginBottom(),
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
            ),
          ],
        ),
      ),
    );
  }
}

class LoginBottom extends StatefulWidget {
  const LoginBottom({Key? key}) : super(key: key);

  @override
  _LoginBottomState createState() => _LoginBottomState();
}

class _LoginBottomState extends State<LoginBottom> {
  late PhoneAuthBloc phoneAuthBloc;
  final phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    phoneAuthBloc = BlocProvider.of<PhoneAuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            kverticalMargin16,
            Text(
              'Lets get you started',
              style: kStyle20Bold,
            ),
            kverticalMargin16,
            BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
              bloc: phoneAuthBloc,
              listener: (_, state) {
                if (state is SendingOTP) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Sending OTP...'),
                    duration: Duration(seconds: 1),
                  ));
                }
                if (state is FailedToSendOTP) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to send OTP. ${state.message}'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
                if (state is OTPSent) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('OTP Sent..'),
                    duration: Duration(seconds: 1),
                  ));
                  Navigator.pushNamedAndRemoveUntil(
                      context, VerifyPhoneScreen.route, (route) => false,
                      arguments: VerifyPhoneScreenArguments(
                          phoneNumber: "+91" + phoneController.text));
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter your phone number',
                      style: kStyle14SemiBold.copyWith(
                          fontWeight: FontWeight.normal),
                    ),
                    kverticalMargin8,
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: kPrimaryColor)),
                        prefixIcon: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              kHorizontalMargin16,
                              Text('+91', style: kStyle14SemiBold),
                              kHorizontalMargin8,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: VerticalDivider(
                                  thickness: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: kPrimaryColor),
                        ),
                      ),
                    ),
                    kverticalMargin8,
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            phoneAuthBloc.add(SendOTP(
                                phoneNumber: "+91" + phoneController.text));
                          },
                          child: Text(
                            'Send OTP',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(kPrimaryColor),
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
                );
              },
            )
          ],
        ));
  }
}
