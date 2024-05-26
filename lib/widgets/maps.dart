//Secret Token = sk.eyJ1IjoibWV0aXMtbWFwYm94IiwiYSI6ImNsdzIwaG1zeTBpNXIyaW11cHp2MThncHMifQ.xgNyF2twUoOad7uocTpUbg

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController _mapController = MapController();
  double _currentZoom = 18;

  // Future<Position>_getCurrentlocation() async {
  //   bool service = await Geolocator.isLocationServiceEnabled();
  //   if (!service) {
  //     return Future.error('Location services are disabled.');
  //   }
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }

  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(23.21049, 72.68475),
          zoom: _currentZoom,
          minZoom: 1,
          maxZoom: 24,
          interactiveFlags: InteractiveFlag.all,
          onPositionChanged: (MapPosition position, bool hasGesture) {
            if (hasGesture) {
              setState(() {
                _currentZoom = position.zoom ?? _currentZoom;
              });
            }
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            maxZoom: 24,
            userAgentPackageName: 'com.metis.insiit',
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoom_in',
            onPressed: () {
              setState(() {
                _currentZoom++;
                _mapController.move(_mapController.center, _currentZoom);
              });
            },
            child: Icon(Icons.zoom_in),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'zoom_out',
            onPressed: () {
              setState(() {
                _currentZoom--;
                _mapController.move(_mapController.center, _currentZoom);
              });
            },
            child: Icon(Icons.zoom_out),
          ),
        ],
      ),
    );
  }
}


// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FlutterMap(
//         options: MapOptions(
//           center: LatLng(23.21049, 72.68475),
//           zoom: 18.2,
//           maxZoom: 22,
//         ),
//         children: [
//           TileLayer(
//             urlTemplate:
//                 'https://{s}.tile.thunderforest.com/{style}/{z}/{x}/{y}{r}.png?apikey={apiKey}',
//             subdomains: ['a', 'b', 'c'],
//             additionalOptions: {
//               'style': 'outdoors',
//               'apiKey': 'e7e012186aa94cca825fbe505dae61a0',
//             },
//             maxZoom: 22,
//             userAgentPackageName: 'com.metis.insiit',
//           ),
//           RichAttributionWidget(
//             attributions: [
//               TextSourceAttribution(
//                 'OpenStreetMap contributors',
//                 onTap: () =>
//                     launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
