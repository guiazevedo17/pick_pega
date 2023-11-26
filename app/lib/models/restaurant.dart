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
  String openDays;
  String openHours;
  String? distance;
  double? userLat;
  double? userLng;
  String? distanceByFoot;
  String? distanceByCar;

  Restaurant( {
   required this.uid,
   required this.name,
   required this.category,
   required this.address,
   required this.lat,
   required this.lng,
   required this.photo,
   required this.openDays,
   required this.openHours,
  });

}

