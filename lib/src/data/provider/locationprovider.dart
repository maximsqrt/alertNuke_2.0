import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider with ChangeNotifier {
  LatLng? _tappedLocation;

  LatLng? get tappedLocation => _tappedLocation;

  void saveTappedLocation(LatLng location) {
    _tappedLocation = location;
    notifyListeners();
  }
}
