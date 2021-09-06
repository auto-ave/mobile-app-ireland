import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

import 'package:themotorwash/blocs/global_location/global_location_bloc.dart';
import 'package:themotorwash/data/models/location_model.dart';
import 'package:themotorwash/theme_constants.dart';

class GrantLocationPermissionScreen extends StatelessWidget {
  final bool forPermission;
  final GlobalLocationBloc globalLocationBloc;
  const GrantLocationPermissionScreen({
    Key? key,
    required this.globalLocationBloc,
    required this.forPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Spacer(),
          SvgPicture.asset('assets/images/grant_location.svg'),
          kverticalMargin8,
          Text(
            'Hey there, Nice to see you!',
            textAlign: TextAlign.center,
            style: kStyle20W500,
          ),
          kverticalMargin8,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              forPermission
                  ? 'Would you please permit us to access your location to serve you in nearby places?'
                  : 'Would you please turn on your location service to serve you in nearby places?',
              style: kStyle14.copyWith(
                color: Color(0xff696969),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          kverticalMargin16,
          LocationButton(
              onPressed:
                  forPermission ? requestPermission : requestLocationService,
              text: forPermission
                  ? 'Grant location permission'
                  : 'Turn on location service'),
          kverticalMargin8,
          GestureDetector(
            onTap: () => globalLocationBloc.add(SetUserLocation(
                location: LocationModel(
                    city: '462001',
                    lat: 23.2599,
                    long: 77.4126))), //TODO : Get lat long for banglore
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Skip for now',
                  style: kStyle16PrimaryColor,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: kPrimaryColor,
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
              style: kStyle14.copyWith(
                color: Color(0xff696969),
              ),
            ),
          ),
        ],
      ),
    );
  }

  requestPermission() async {
    try {
      var locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.deniedForever) {
        Geolocator.openAppSettings();
      }
      if (locationPermission == LocationPermission.always ||
          locationPermission == LocationPermission.whileInUse) {
        globalLocationBloc.add(GetCurrentUserLocation());
      }
    } catch (e) {
      print(e.toString());
    }
  }

  requestLocationService() async {
    var result = await Location().requestService();
    if (result) {
      globalLocationBloc.add(GetCurrentUserLocation());
    }
  }
}

class LocationButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  const LocationButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Icon(
            Icons.my_location_rounded,
            color: Colors.white,
          )),
      onPressed: onPressed,
      label: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kPrimaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
