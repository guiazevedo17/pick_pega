import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:pick_pega/models/address.dart';
import 'package:pick_pega/models/restaurant.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../components/section.dart';
import '../models/shopping_bag.dart';

class SearchRestaurant extends StatefulWidget {
  const SearchRestaurant({Key? key}) : super(key: key);


  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  SearchRestaurant? searchRestaurant;
  List<Restaurant> closeRestaurant = [];
  double? latitude;
  double? longitude;
  List<Restaurant> sugestionRes = [];
  List<Restaurant> allRestaurants = [];

  Future<double> calcularTempoAPe(double origemLat, double origemLng, double destinoLat, double destinoLng) async {
    String apiUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origemLat,$origemLng&destinations=$destinoLat,$destinoLng&mode=walking&key=AIzaSyDTN9yBqoVdrDor1gaBWxQkywlpCS9Wi_o';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final durationInSeconds = data['rows'][0]['elements'][0]['duration']['value'];
      return durationInSeconds/60;
    } else {
      throw Exception('Erro ao calcular o tempo de viagem a pé.');
    }
  }

  Future<double> calcularTempoDeCarro(double origemLat, double origemLng, double destinoLat, double destinoLng) async {
    String apiUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origemLat,$origemLng&destinations=$destinoLat,$destinoLng&mode=driving&key=AIzaSyDTN9yBqoVdrDor1gaBWxQkywlpCS9Wi_o';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final durationInSeconds = data['rows'][0]['elements'][0]['duration']['value'];
      return durationInSeconds/60;
    } else {
      throw Exception('Erro ao calcular o tempo de viagem de carro.');
    }
  }


  Future<List<Restaurant>> getAllRestaurants() async {
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

      allRestaurants = listOfRestaurants.map((restaurantMap) {
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
      await pegarPosicao();
      print("latitude: $latitude");
      funcCloseRestaurants(latitude!, longitude!, allRestaurants);
      await calcularTempo(latitude!, longitude!, allRestaurants);
      return allRestaurants;
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }

  Future<void>calcularTempo( double lat, double lng,List<Restaurant> allRestaurants) async {
    for (var restaurant in allRestaurants) {
      double byFoot = await calcularTempoAPe(
          lat, lng, restaurant.lat, restaurant.lng);
      double byCar = await calcularTempoDeCarro(
          lat, lng, restaurant.lat, restaurant.lng);
      print(byCar);
      double byFootHour = byFoot;
      double byCarHour = byCar;
      if(byFoot > 60) {
        byFootHour = byFoot/60;
        restaurant.distanceByFoot = "${byFootHour.toStringAsFixed(1)} h";
      } else {
        restaurant.distanceByFoot = "${byFoot.toStringAsFixed(1)} min";
      }
      if(byCar > 60) {
        byCarHour = byCar/60;
        restaurant.distanceByCar = "${byCarHour.toStringAsFixed(1)} h";
      } else {
        restaurant.distanceByCar = "${byCar.toStringAsFixed(1)} min";
      }
    }
  }

  pegarPosicao() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;

  }

  Future<void> funcCloseRestaurants(
      double lat, double lng, List<Restaurant> allRestaurants) async {
    for (var restaurant in allRestaurants) {
      double distancia = await Geolocator.distanceBetween(
        lat,
        lng,
        restaurant.lat ?? 0,
        restaurant.lng ?? 0,
      );
      double distanciaKm = distancia/1000;
      String distanciaFormatada = distanciaKm.toStringAsFixed(1);
      restaurant.distance = distanciaFormatada;
      if (distancia <= 2000) {
        // 2 km em metros
        closeRestaurant.add(restaurant);
      } else{
        sugestionRes.add(restaurant);
      }
    }
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: FutureBuilder<List<Restaurant>>(
        future: getAllRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum restaurante disponível.'));
          } else {
            List<Restaurant> restaurants = snapshot.data!;

            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //App Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1,
                        bottom: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo
                          SizedBox(
                              width: 40,
                              height: 46,
                              child: Image.asset('assets/images/logo.png')),

                          // Search Bar
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(16.0, 0, 10.0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: lightgrey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextField(
                                  controller: _controller,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Buscar...',
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Location Button
                          GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                              '/location',
                              arguments: restaurants,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: actionYellow),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.location_pin,
                                  color: white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Section Contents
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          // Close Restaurants Section
                          Section('Restaurantes Próximos', closeRestaurant,
                              MediaQuery.of(context).size.height * 0.08),

                          // Sugestions Section
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                            ),
                            child: Section('Sugestões', sugestionRes,
                                MediaQuery.of(context).size.height * 0.19),
                          ),

                          // Sales Section
                          Section('No precinho', allRestaurants,
                              MediaQuery.of(context).size.height * 0.23)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
