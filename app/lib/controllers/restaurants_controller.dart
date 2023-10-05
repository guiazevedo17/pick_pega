import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RestaurantsController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String error = "";

  RestaurantsController() {
    getPosition();
  }

  getPosition() async {
    try {
      Position position = await _currentPosition();
      lat = position.latitude;
      long = position.longitude;

    } catch (e) {
      error = e.toString();
    }

    notifyListeners();
  }

  Future<Position> _currentPosition() async {
    LocationPermission permission;

    // Verify Location Service
    bool activated = await Geolocator.isLocationServiceEnabled();

    if (!activated) {
      return Future.error('Por favor, habilite a localização do dispositivo');
    }

    // Check if permission already exists
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission(); // Request permission again
      if (permission == LocationPermission.denied) {
        // In case the request is denied again
        return Future.error('Você precisa autorizar o acesso a localização');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso à localização');
    } // Need manual authorization

    return await Geolocator.getCurrentPosition(); // Latitude + Longitude
  }
}
