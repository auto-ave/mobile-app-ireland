import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/email_auth/bloc/email_auth_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/data/repos/auth_repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/login/phone_login_screen.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/screens/verify_phone/verify_phone_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils/utils.dart';

class EmailAuthenticationBottomSheet extends StatefulWidget {
  final CartFunctionEvent event;
  final CartFunctionBloc cartBloc;
  final BuildContext ctx;
  const EmailAuthenticationBottomSheet(
      {Key? key,
      required this.event,
      required this.cartBloc,
      required this.ctx})
      : super(key: key);

  @override
  _EmailAuthenticationBottomSheetState createState() =>
      _EmailAuthenticationBottomSheetState();
}

class _EmailAuthenticationBottomSheetState
    extends State<EmailAuthenticationBottomSheet> {
  late EmailAuthBloc _emailAuthBloc;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _emailAuthBloc = EmailAuthBloc(
        repository: RepositoryProvider.of<AuthRepository>(context),
        globalAuthBloc: BlocProvider.of<GlobalAuthBloc>(context),
        localDataService: getIt.get<LocalDataService>(
            instanceName: LocalDataService.getItInstanceName),
        fcmInstance: FirebaseMessaging.instance);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmailAuthBloc, EmailAuthState>(
      bloc: _emailAuthBloc,
      listener: (_, state) {
        if (state is EmailAuthError) {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is EmailAuthenticated) {
          widget.cartBloc.add(widget.event);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        if (state is EmailAuthLoading) {
          return Container(
            child: Center(child: loadingAnimation()),
            height: 30.h,
          );
        }

        return getEmailAuthWidget();
      },
    );
  }

  getEmailAuthWidget() {
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
          Text('Continue with email'),
          SizeConfig.kverticalMargin8,
          Form(
            child: Column(
              children: [
                CommonTextField(
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
                ),
                SizeConfig.kverticalMargin8,
                CommonTextField(
                  keyboardType: TextInputType.emailAddress,
                  fieldController: emailController,
                  validator: validateEmail,
                  hintText: 'Email',
                  filled: false,
                  // focusNode: _phoneFocusNode,
                )
              ],
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
                      _emailAuthBloc.add(AuthenticateEmailAndName(
                          email: emailController.text,
                          firstName: nameController.text,
                          lastName: ' b'));
                    }
                  },
                  backgroundColor: SizeConfig.kPrimaryColor,
                  buttonSemantics: 'Login Email BottomSheet',
                  child: Text(
                    'Login',
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailAuthBloc.close();
  }
}
