import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/feedback/bloc/feedback_bloc.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/feedback/contact_option_button.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils.dart';

class FeedbackScreen extends StatefulWidget {
  final bool isFeedback;
  FeedbackScreen({Key? key, required this.isFeedback}) : super(key: key);
  static final String route = '/feedbackScreen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final _feedbackBloc;

  @override
  void initState() {
    super.initState();
    _feedbackBloc =
        FeedbackBloc(repository: RepositoryProvider.of<Repository>(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarWithBackButton(
          context: context,
          title: Text(
            'Feedback',
            style: TextStyle(color: Colors.black),
          )),
      body: BlocListener<FeedbackBloc, FeedbackState>(
        bloc: _feedbackBloc,
        listener: (context, state) {
          if (state is FeedbackSent) {
            showSnackbar(context, 'Thank you for your valuable feedback.');
          }
          if (state is FeedbackError) {
            showSnackbar(
                context, 'Error sending feedback. Please try again later');
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // CommonTextField(
                //   fieldName: 'Email',
                //   fieldController: emailController,
                //   validator: validateEmail,
                // ),
                // kverticalMargin16,
                // CommonTextField(
                //   fieldName: 'Phone',
                //   fieldController: phoneController,
                //   validator: validatePhone,
                // ),
                // kverticalMargin16,
                Text(
                  'We did love to hear from you',
                  style: kStyle16W500,
                ),
                kverticalMargin8,
                Text(
                  'If you have any questions, feedback or any problems please contact us. We are happy to hear from you',
                  style: kStyle12.copyWith(color: kGreyTextColor),
                ),
                kverticalMargin16,
                Text(
                  'Your message',
                  style: kStyle12W500,
                ),
                kverticalMargin8,
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  child: CommonTextField(
                    fieldController: messageController,
                    validator: (string) {
                      if (string != null) {
                        if (string.trim().isEmpty) {
                          return 'field cannot be empty';
                        }
                        return null;
                      }
                      return 'field cannot be empty';
                    },
                    maxLines: 100,
                    filled: false,
                  ),
                ),
                kverticalMargin16,
                BlocBuilder<FeedbackBloc, FeedbackState>(
                  bloc: _feedbackBloc,
                  builder: (context, state) {
                    return CommonTextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _feedbackBloc.add(SendFeedback(
                                email: emailController.text,
                                phone: phoneController.text,
                                message: messageController.text));
                          }
                        },
                        child: state is FeedbackLoading
                            ? SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  backgroundColor: Colors.white,
                                ),
                                width: 25,
                                height: 25,
                              )
                            : Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ),
                        backgroundColor: kPrimaryColor);
                  },
                ),
                kverticalMargin32,
                Row(
                  children: [
                    Expanded(child: Divider()),
                    kHorizontalMargin8,
                    Text('OR'),
                    kHorizontalMargin8,
                    Expanded(child: Divider()),
                  ],
                ),
                kverticalMargin32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ContactOptionButton(
                        onTap: () {},
                        text: 'Mail',
                        svgAsset: 'assets/icons/mail.svg'),
                    ContactOptionButton(
                        onTap: () {},
                        text: 'Mail',
                        svgAsset: 'assets/icons/call.svg'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
