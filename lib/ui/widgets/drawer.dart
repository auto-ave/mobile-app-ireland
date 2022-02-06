import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:themotorwash/blocs/cart/cart_function_bloc.dart';
import 'package:themotorwash/blocs/global_auth/global_auth_bloc.dart';
import 'package:themotorwash/blocs/global_cart/bloc/global_cart_bloc.dart';
import 'package:themotorwash/blocs/phone_auth/phone_auth_bloc.dart';
import 'package:themotorwash/data/local/local_data_service.dart';
import 'package:themotorwash/navigation/arguments.dart';
import 'package:themotorwash/theme_constants.dart';
import 'package:themotorwash/ui/screens/explore/explore_screen.dart';
import 'package:themotorwash/ui/screens/feedback/feedback_screen.dart';
import 'package:themotorwash/ui/screens/login/login_screen.dart';
import 'package:themotorwash/ui/screens/profile/profile_screen.dart';
import 'package:themotorwash/ui/screens/your_bookings/your_bookings_screen.dart';
import 'package:themotorwash/ui/widgets/common_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalAuthBloc, GlobalAuthState>(
      builder: (context, state) {
        print('Satatebi' + state.toString());
        if (state is Authenticated) {
          return Drawer(
              child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              children: <Widget>[
                _createDrawerHeader(context),
                Divider(
                  thickness: 1,
                  height: 0,
                ),
                _createDrawerItem(
                    context, 'orders_drawer.svg', Text("Your Orders"), () {
                  Navigator.pushNamed(context, YourBookingsScreen.route,
                      arguments: YourBookingsScreenArguments(
                          fromBookingSummary: false));
                }),
                Divider(
                  thickness: 1,
                  height: 0,
                ),
                _createDrawerItem(context, 'user_drawer.svg', Text("Profile"),
                    () {
                  Navigator.pushNamed(context, ProfileScreen.route,
                      arguments: ProfileScreenArguments(showSkip: false));
                }),
                Divider(
                  thickness: 1,
                  height: 0,
                ),
                _createDrawerItem(
                    context, 'feedback_drawer.svg', Text("Feedback"), () {
                  Navigator.pushNamed(context, FeedbackScreen.route,
                      arguments: FeedbackScreenArguments(isFeedback: true));
                }),
                Spacer(),
                Divider(),
                _createDrawerItem(
                  context,
                  'log_out_drawer.svg',
                  Text("Log out"),
                  () async {
                    BlocProvider.of<CartFunctionBloc>(context)
                      ..add(ClearLocalCart());
                    BlocProvider.of<PhoneAuthBloc>(context)..add(LogOut());
                  },
                ),
              ],
            ),
          ));
        }
        return Drawer(
            child: Column(
          children: [
            _createDrawerHeader(context),
            Expanded(
                child: Center(
                    child: CommonTextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  LoginScreen.route,
                );
              },
              child: Text(
                'Login/Signup',
                style: SizeConfig.kStyle14PrimaryColor,
              ),
              backgroundColor: Colors.white,
              border: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: SizeConfig.kPrimaryColor)),
            ))),
          ],
        ));
      },
    );
  }

  Widget _createDrawerHeader(
    BuildContext context,
  ) {
    final totalHeight = 100.h;
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.mediaQueryData.padding.top,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              gradient: LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: [
                  Theme.of(context).primaryColor,
                  Color(0xff24C6DC),
                ],
              ),
            ),
          ),
          Container(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.route,
                    arguments: ProfileScreenArguments(showSkip: false));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    child: FaIcon(FontAwesomeIcons.user),
                    backgroundColor: Colors.white,
                    radius: totalHeight * .05,
                  ),
                ),
              ),
            ),
            height: totalHeight * .2,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              gradient: LinearGradient(
                end: Alignment.centerRight,
                begin: Alignment.centerLeft,
                colors: [
                  Theme.of(context).primaryColor,
                  Color(0xff24C6DC),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      BuildContext context, String iconAddress, Text title, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListTile(
        dense: true,
        leading: SvgPicture.asset('assets/icons/$iconAddress'),
        title: SizedBox(child: title),
        onTap: () {
          Navigator.pop(context);
          onTap();
        },
      ),
    );
  }
}
