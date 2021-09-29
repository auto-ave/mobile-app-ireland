import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreGoogleMap extends StatefulWidget {
  final double latitute;
  final double longitute;
  const StoreGoogleMap({
    Key? key,
    required this.latitute,
    required this.longitute,
  }) : super(key: key);
  @override
  State<StoreGoogleMap> createState() => StoreGoogleMapState();
}

class StoreGoogleMapState extends State<StoreGoogleMap> {
  Completer<GoogleMapController> _controller = Completer();
  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.latitute, widget.longitute),
      zoom: 14.4746,
    );
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(widget.latitute, -122.08832357078792),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  late final CameraPosition _kGooglePlex;

  late final CameraPosition _kLake;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .26,
      child: GoogleMap(
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: [
          Marker(
              markerId: MarkerId('default'),
              position: LatLng(widget.latitute, widget.longitute))
        ].toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
