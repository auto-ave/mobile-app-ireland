import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themotorwash/blocs/feedback/bloc/feedback_bloc.dart';
import 'package:themotorwash/data/repos/repository.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';
import 'package:themotorwash/utils.dart';

class FeedbackScreen extends StatefulWidget {
  FeedbackScreen({Key? key}) : super(key: key);
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
        child: Center(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonTextField(
                    fieldName: 'Email',
                    fieldController: emailController,
                    validator: validateEmail,
                  ),
                  kverticalMargin16,
                  CommonTextField(
                    fieldName: 'Phone',
                    fieldController: phoneController,
                    validator: validatePhone,
                  ),
                  kverticalMargin16,
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    child: CommonTextField(
                      hintText: 'Message',
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
                    ),
                  ),
                  kverticalMargin32,
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
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
