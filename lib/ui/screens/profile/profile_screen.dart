import 'package:flutter/material.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/home/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailtNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        persistentFooterButtons: [
          TextButton(
            child: Text('Save', style: TextStyle(color: Colors.white)),
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
          ),
        ],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            // Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.route, (route) => false),
                child: Text(
                  'skip',
                  style: kStyle16PrimaryColor,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(color: kPrimaryColor, width: 2)),
                    child: Image.asset('assets/images/avatar.png'),
                  ),
                  Positioned(
                    child: Container(
                      height: 24,
                      width: 24,
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: kPrimaryColor),
                    ),
                    bottom: 0,
                    right: 0,
                  )
                ],
              ),
              kverticalMargin16,
              kverticalMargin8,
              ProfileTextField(
                  fieldName: 'First Name',
                  fieldController: firstNameController),
              kverticalMargin16,
              ProfileTextField(
                  fieldName: 'Last Name', fieldController: lastNameController),
              kverticalMargin16,
              ProfileTextField(
                  fieldName: 'Email', fieldController: emailtNameController)
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String fieldName;
  final TextEditingController fieldController;

  const ProfileTextField(
      {Key? key, required this.fieldName, required this.fieldController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF2F8FF),
      child: TextFormField(
        controller: fieldController,
        style: kStyle14W500,
        decoration: InputDecoration(
          labelText: fieldName,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: kPrimaryColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(color: kPrimaryColor)),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
