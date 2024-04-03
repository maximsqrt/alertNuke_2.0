import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:unicons/unicons.dart';

class MapCalendar extends StatefulWidget {
  const MapCalendar({Key? key}) : super(key: key);

  @override
  State<MapCalendar> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapCalendar> {
  final MapController mapController = MapController();

  void zoomOut() {
    var newZoom =
        mapController.zoom - 1; // Reduziert den aktuellen Zoom-Level um 1
    mapController.move(mapController.center, newZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center:
                  LatLng(48.137154, 11.576124), // Standard-Zentrum der Karte
              zoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://tile.thunderforest.com/spinal-map/{z}/{x}/{y}.png?apikey=b3250019b1cf4c329cd29f1166421e6a",
                additionalOptions: {
                  'apikey': 'b3250019b1cf4c329cd29f1166421e6a',
                },
              ),
              // Weitere Layer oder Widgets können hier hinzugefügt werden
            ],
          ),
          Positioned(
  right: 0,
  top: (MediaQuery.of(context).size.height - 80) / 2,
  child: Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(UniconsLine.zero_plus),
          onPressed: zoomOut,
          // Stilisiere den Button nach Bedarf
        ),
                  // Weitere Buttons oder Widgets können hier hinzugefügt werden
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
