import 'address.dart';

class Restaurant {
  String uid;
  String name;
  String category;
  Address address;
  double lat;
  double lng;
  String photo;

  Restaurant( {
   required this.uid,
   required this.name,
   required this.category,
   required this.address,
   required this.lat,
   required this.lng,
   required this.photo,
  });


  // factory Restaurant.fromJson(Map<String, dynamic> json) {
  //   return Restaurant(
  //       uid: json['uid'],
  //       name: json['name'],
  //       email: json['email'],
  //       password: json['password'],
  //       category: json['category'],
  //       address: json['address'],
  //       lat: json['lat'],
  //       lng: json['lng'],
  //       photo: json['photo'],
  //       );
  //   }

    // Distância da localização atual
    // double distance = currentDistance() -> return double dist

    // Tempo a Pé partindo da localização atual
    // double walking = walkingTime() -> return double walk


    // Tempo de Carro partindo da localização atual
    // double driving = drivingTime() -> return double drive

}

