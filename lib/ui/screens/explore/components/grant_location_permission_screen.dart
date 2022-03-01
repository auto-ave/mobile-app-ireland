import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/data/analytics/analytics_events.dart';
import 'package:themotorwash/data/models/location_model.dart';
import 'package:themotorwash/main.dart';
import 'package:themotorwash/theme_constants.dart';

class GrantLocationPermissionScreen extends StatefulWidget {
  final bool forPermission;
  final GlobalLocationBloc globalLocationBloc;
  bool isLoading;
  GrantLocationPermissionScreen({
    Key? key,
    required this.globalLocationBloc,
    required this.forPermission,
    this.isLoading = false,
  });

  @override
  State<GrantLocationPermissionScreen> createState() =>
      _GrantLocationPermissionScreenState();
}

class _GrantLocationPermissionScreenState
    extends State<GrantLocationPermissionScreen> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = widget.isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Spacer(),
            SvgPicture.asset('assets/images/grant_location.svg'),
            SizeConfig.kverticalMargin8,
            Text(
              'Hey there, Nice to see you!',
              textAlign: TextAlign.center,
              style: SizeConfig.kStyle20W500,
            ),
            SizeConfig.kverticalMargin8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                widget.forPermission
                    ? 'Would you please permit us to access your location to serve you in nearby places?'
                    : 'Would you please turn on your location service to serve you in nearby places?',
                style: SizeConfig.kStyle14.copyWith(
                  color: Color(0xff696969),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizeConfig.kverticalMargin16,
            LocationButton(
              onPressed: widget.forPermission
                  ? requestPermission
                  : requestLocationService,
              text: widget.forPermission
                  ? 'Grant location permission'
                  : 'Turn on location service',
              isLoading: isLoading,
            ),
            SizeConfig.kverticalMargin8,
            GestureDetector(
              behavior: HitTestBehavior.opaque,

              onTap: () {
                widget.globalLocationBloc.add(SkipUserLocation());
                mixpanel?.track(SkipLocationAnalytics().eventName());
              }, //TODO : Get lat long for banglore
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Skip for now',
                    style: SizeConfig.kStyle16PrimaryColor,
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: SizeConfig.kPrimaryColor,
                    size: 20,
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'We only access your location while you are using the app to improve your experience',
                textAlign: TextAlign.center,
                style: SizeConfig.kStyle14.copyWith(
                  color: Color(0xff696969),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  requestPermission() async {
    try {
      setState(() {
        isLoading = true;
      });
      var locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        setState(() {
          isLoading = false;
        });
        Geolocator.openAppSettings();
      }

      if (locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.whileInUse) {
        setState(() {
          isLoading = false;
        });
        widget.globalLocationBloc.add(GetCurrentUserLocation());
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
    }
  }

  requestLocationService() async {
    setState(() {
      isLoading = true;
    });
    var result = await Location().requestService();
    if (result) {
      widget.globalLocationBloc.add(GetCurrentUserLocation());
    }
    setState(() {
      isLoading = false;
    });
  }
}

class LocationButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  bool isLoading;
  LocationButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: isLoading
          ? SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.my_location_rounded,
                color: Colors.white,
              )),
      onPressed: onPressed,
      label: isLoading
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ))
          : Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(SizeConfig.kPrimaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
