//Secret Token = sk.eyJ1IjoibWV0aXMtbWFwYm94IiwiYSI6ImNsdzIwaG1zeTBpNXIyaW11cHp2MThncHMifQ.xgNyF2twUoOad7uocTpUbg

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // MapController _mapController = MapController();
  // double _currentZoom = 18;

  @override
  Widget build(BuildContext context) {
    String ACCESS_TOKEN = const String.fromEnvironment("ACCESS_TOKEN");
    MapboxOptions.setAccessToken(ACCESS_TOKEN);

    CameraOptions camera = CameraOptions(
        center: Point(coordinates: Position(72.68475, 23.21049)),
        zoom: 17,
        bearing: 0,
        pitch: 55);

    return Scaffold(
        body: MapWidget(
      cameraOptions: camera,
    )

        // FlutterMap(
        //   mapController: _mapController,
        //   options: MapOptions(
        //     center: LatLng(23.21049, 72.68475),
        //     zoom: _currentZoom,
        //     minZoom: 1,
        //     maxZoom: 24,
        //     interactiveFlags: InteractiveFlag.all,
        //     onPositionChanged: (MapPosition position, bool hasGesture) {
        //       if (hasGesture) {
        //         setState(() {
        //           _currentZoom = position.zoom ?? _currentZoom;
        //         });
        //       }
        //     },
        //   ),
        //   children: [
        //     TileLayer(
        //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        //       subdomains: ['a', 'b', 'c'],
        //       maxZoom: 24,
        //       userAgentPackageName: 'com.metis.insiit',
        //     )
        //   ],
        // ),
        // floatingActionButton: Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(
        //       heroTag: 'zoom_in',
        //       onPressed: () {
        //         setState(() {
        //           _currentZoom++;
        //           _mapController.move(_mapController.center, _currentZoom);
        //         });
        //       },
        //       child: Icon(Icons.zoom_in),
        //     ),
        //     SizedBox(height: 8),
        //     FloatingActionButton(
        //       heroTag: 'zoom_out',
        //       onPressed: () {
        //         setState(() {
        //           _currentZoom--;
        //           _mapController.move(_mapController.center, _currentZoom);
        //         });
        //       },
        //       child: Icon(Icons.zoom_out),
        //     ),
        //   ],
        // ),
        );
  }
}
