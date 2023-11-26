import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import '../models/address.dart';
import '../models/restaurant.dart';

class RestaurantsController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String error = "";
  late GoogleMapController _mapsController;
  Set<Marker> markers = Set<Marker>();
  get mapsController => _mapsController;
  List<Restaurant> restaurants = [];
  RestaurantsController() {
    getPosition();
  }

  Future<void> getAllRestaurants() async {
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getAllRestaurants');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);

      // Acesse o valor da chave 'payload' no JSON
      final payload = jsonBody['payload'];

      // Agora, 'payload' é uma lista de elementos
      List<Map<String, dynamic>> listOfRestaurants =
      List<Map<String, dynamic>>.from(payload);

      restaurants = listOfRestaurants.map((restaurantMap) {
        return Restaurant(
          uid: restaurantMap['uid'],
          name: restaurantMap['name'],
          category: restaurantMap['category'],
          address: Address(
              zip: restaurantMap['address[zip]'],
              number: restaurantMap['address[number]'],
              uf: restaurantMap['address[uf]'],
              city: restaurantMap['address[city]'],
              street: restaurantMap['address[street]'],
              neighborhood: restaurantMap['address[neighborhood]']),
          lat: restaurantMap['lat'],
          lng: restaurantMap['lng'],
          photo: restaurantMap['photo'],
          openDays: restaurantMap['openDays'],
          openHours: restaurantMap['openHours']
        );
      }).toList();


    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
    }
  }


  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    print("ENTROU");
    getPosition();
    await getAllRestaurants();
    loadMarkers();


  }

  loadMarkers() {
    for(var restaurant in restaurants) {
      print(restaurant.name);
      markers.add(Marker(
        markerId: MarkerId(restaurant.uid.toString()),
        position: LatLng(restaurant.lat, restaurant.lng),
        infoWindow: InfoWindow(title: restaurant.name),

      )
      );

      notifyListeners();
    }
  }

  getPosition() async {
    try {
      Position position = await _currentPosition();
      lat = position.latitude;
      long = position.longitude;
      _mapsController.animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
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
