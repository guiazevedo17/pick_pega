import 'package:geolocator/geolocator.dart';
import 'address.dart';

class Restaurant {
  String uid;
  String name;
  String category;
  Address address;
  double lat;
  double lng;
  String photo;

  double? userLat;
  double? userLng;

  double? distance;

  double? walking;
  double? driving;

  Restaurant({
    required this.uid,
    required this.name,
    required this.category,
    required this.address,
    required this.lat,
    required this.lng,
    required this.photo,
  });

  getPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    userLat = position.latitude;
    userLng = position.longitude;
  }

  // Distância da localização atual
  Future<void> defineDistance() async {
    distance = await Geolocator.distanceBetween(
      lat,
      lng,
      userLat ?? 0,
      userLng ?? 0,
    );
  }

  // Tempo a Pé partindo da localização atual
  // double walking = walkingTime() -> return double walk

  // Tempo de Carro partindo da localização atual
  // double driving = drivingTime() -> return double drive
}
