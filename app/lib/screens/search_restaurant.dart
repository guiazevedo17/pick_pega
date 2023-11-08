import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:pick_pega/models/address.dart';
import 'package:pick_pega/models/restaurant.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:http/http.dart' as http;
import '../components/section.dart';

class SearchRestaurant extends StatefulWidget {
  SearchRestaurant({Key? key}) : super(key: key);

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  double? latitude;
  double? longitude;
  List<Restaurant> closeRes = [];
  List<Restaurant> sugestionRes = [];
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

      List<Restaurant> restaurants = listOfRestaurants.map((restaurantMap) {
        return Restaurant(
          uid: restaurantMap['uid'],
          name: restaurantMap['name'],
          email: restaurantMap['email'],
          password: restaurantMap['password'],
          address: Address(
            zip: restaurantMap['address[zip]'],
            number: restaurantMap['address[number]'],
            uf: restaurantMap['address[uf]'],
            city: restaurantMap['address[city]'],
            street: restaurantMap['address[street]'],
            neighborhood: restaurantMap['address[neighborhood]']
          ),
          lat: restaurantMap['lat'],
          lng: restaurantMap['lng'],
          photo: restaurantMap['photo'],
        );
      }).toList();

      funcCloseRestaurants(-22.8346193, -47.0560734, restaurants).then((proximos) {
        closeRes = proximos;

        // for (var restaurante in proximos) {
        //   // print("Nome: ${restaurante.name}");
        //   // print("Latitude: ${restaurante.lat}");
        //   // print("Longitude: ${restaurante.lng}");
        //   closeRes.add(restaurante);
        // }

      }).catchError((error) {
        print("Erro ao calcular os restaurantes próximos: $error");
      });
      print(closeRes);

      print("TESTE: $restaurants");
      return restaurants;
    
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }

  pegarPosicao() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
    print(position);
  }

  Future<List<Restaurant>> funcCloseRestaurants(double lat, double lng,List<Restaurant> allRestaurants) async {
    List<Restaurant> closeRestaurants = [];
    sugestionRes = allRestaurants;
    for (var restaurant in allRestaurants) {
      double distancia = await Geolocator.distanceBetween(
        lat, lng, restaurant.lat ?? 0, restaurant.lng ?? 0,
      );

      if (distancia <= 2000) { // 2 km em metros
        closeRestaurants.add(restaurant);
        sugestionRes.remove(restaurant);
      }
    }

    return closeRestaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: FutureBuilder<List<Restaurant>>(
        future: getAllRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Center(child: CircularProgressIndicator());

          } else if (snapshot.hasError) {

            return Center(child: Text('Erro: ${snapshot.error}'));

          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

            return const Center(child: Text('Nenhum restaurante disponível.'));

          } else {
            List<Restaurant> restaurants = snapshot.data!;

            List<Restaurant> closeRestaurant = [];



            return SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  //App Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery
                            .of(context)
                            .size
                            .height * 0.1,
                        bottom: MediaQuery
                            .of(context)
                            .size
                            .height * 0.05,
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
                              padding: const EdgeInsets.fromLTRB(16.0, 0, 10.0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: lightgrey,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const TextField(
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
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
                            onTap: () {
                              Navigator.of(context).pushNamed('/location');
                            },
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
                          Section('Restaurantes Próximos', closeRes,
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.08),

                          // Sugestions Section
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                              bottom: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.05,
                            ),
                            child: Section('Sugestões', sugestionRes,
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.19),
                          ),

                          // Sales Section
                          Section('No precinho', restaurants,
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.23)
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
