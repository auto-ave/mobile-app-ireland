import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:themotorwash/theme_constants.dart';

class DirectionsButton extends StatelessWidget {
  final double latitude;
  final double longitude;
  const DirectionsButton({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            elevation: MaterialStateProperty.all(1),
            backgroundColor: MaterialStateProperty.all(SizeConfig.kBadgeColor)),
        onPressed: () async {
          final availableMaps = await MapLauncher.installedMaps;
          print(
              availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

          await availableMaps.first
              .showDirections(destination: Coords(latitude, longitude));
        },
        icon: SvgPicture.asset(
          'assets/icons/map.svg',
          width: 24,
        ),
        label: Text(
          'Directions',
          style: SizeConfig.kStyle12.copyWith(color: Colors.black),
        ));
  }
}
