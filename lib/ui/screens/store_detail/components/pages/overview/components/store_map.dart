import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:themotorwash/theme_constants.dart';

class StoreMap extends StatefulWidget {
  final double latitute;
  final double longitute;
  StoreMap({
    Key? key,
    required this.latitute,
    required this.longitute,
  }) : super(key: key);

  @override
  _StoreMapState createState() => _StoreMapState();
}

class _StoreMapState extends State<StoreMap> {
  MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .26,
      child: FlutterMap(
        mapController: _mapController,
        children: [
          Container(
            child: Text("ASD"),
          )
        ],
        options: MapOptions(
          center: LatLng(widget.latitute, widget.longitute),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(widget.latitute, widget.longitute),
                builder: (ctx) => Container(
                  child: Icon(Icons.location_on),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.all(color: SizeConfig.kPrimaryColor, width: 2),
          borderRadius: BorderRadius.circular(5)),
    );
  }
}
