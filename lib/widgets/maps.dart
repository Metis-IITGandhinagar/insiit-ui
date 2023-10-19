import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
   MapController mapController = MapController(
    initPosition: GeoPoint(latitude: 23.21049 , longitude: 72.68475),
    areaLimit: BoundingBox(
          north: 23.22817602890616,
          east: 72.70700454711915,
          south: 23.18810234082923,
          west: 72.66408920288087)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          OSMFlutter( 
        controller:mapController,
        osmOption: OSMOption(
              showZoomController: true,
              userTrackingOption: const UserTrackingOption(
              enableTracking: true,
              unFollowUser: false,
              
            ),
            zoomOption: const ZoomOption(
                  initZoom: 17,
                  minZoomLevel: 10,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
            ),
            userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                    icon: Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: 48,
                    ),
                ),
                directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                        Icons.double_arrow,
                        size: 48,
                    ),
                ),
            ),
            roadConfiguration: const RoadOption(
                    roadColor: Colors.yellowAccent,
            ),
            markerOption: MarkerOption(
                defaultMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 56,
                    ),
                )
            ),
        )
    )

        ],
      ),
    ) ;
  }
}
