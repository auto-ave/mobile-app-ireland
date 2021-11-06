import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themotorwash/theme_constants.dart';

class StoreGoogleMap extends StatefulWidget {
  final double latitute;
  final double longitute;
  final String storeTitle;

  const StoreGoogleMap(
      {Key? key,
      required this.latitute,
      required this.longitute,
      required this.storeTitle})
      : super(key: key);
  @override
  State<StoreGoogleMap> createState() => StoreGoogleMapState();
}

class StoreGoogleMapState extends State<StoreGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    _kPinnedCamera = CameraPosition(
      target: LatLng(widget.latitute, widget.longitute),
      zoom: 14.4746,
    );

    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(widget.latitute, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  // late final CameraPosition _kGooglePlex;

  late final CameraPosition _kLake;
  late final CameraPosition _kPinnedCamera;
  bool isMapVisible = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedOpacity(
            curve: Curves.fastOutSlowIn,
            opacity: isMapVisible ? 1.0 : 0,
            duration: Duration(milliseconds: 600),
            child: Container(
              height: MediaQuery.of(context).size.height * .26,
              child: GoogleMap(
                liteModeEnabled: false,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  new Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer(),
                  ),
                ].toSet(),
                mapType: MapType.normal,
                initialCameraPosition: _kPinnedCamera,
                markers: [
                  Marker(
                      markerId: MarkerId('default'),
                      position: LatLng(widget.latitute, widget.longitute),
                      infoWindow: InfoWindow(title: widget.storeTitle)),
                ].toSet(),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  Future.delayed(const Duration(milliseconds: 550), () {
                    if (mounted) {
                      setState(() {
                        isMapVisible = true;
                      });
                    }
                  });
                },
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: SizeConfig.kPrimaryColor, width: 2),
                  borderRadius: BorderRadius.circular(5)),
            )),
        Positioned(
          child: GestureDetector(
            onTap: _goToPinned,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(Icons.location_searching),
            ),
          ),
          left: 8,
          bottom: 8,
        )
      ],
    );
  }

  Future<void> _goToPinned() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kPinnedCamera));
  }
}
