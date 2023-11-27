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
  Restaurant? searchRestaurantByName;

  Future<void> getRestaurantByName(TextEditingController controller) async {
    String nome = controller.text;
    print("getRestaurantByName: $nome");
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getRestaurantByName/$nome');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);

      // Acesse o valor da chave 'payload' no JSON
      final payload = jsonBody['payload'];

      // Agora, 'payload' é uma lista de elementos

      print(payload);
      searchRestaurantByName = Restaurant(
            uid: payload[0]['uid'],
            name: payload[0]['name'],
            category: payload[0]['category'],
            address: Address(
                zip: payload[0]['address[zip]'],
                number: payload[0]['address[number]'],
                uf: payload[0]['address[uf]'],
                city: payload[0]['address[city]'],
                street: payload[0]['address[street]'],
                neighborhood: payload[0]['address[neighborhood]']),
            lat: payload[0]['lat'],
            lng: payload[0]['lng'],
            photo: payload[0]['photo'],
            openDays: payload[0]['openDays'],
            openHours: payload[0]['openHours']
        );

      Navigator.of(context).pushNamed(
        '/restaurant_menu',
        arguments: searchRestaurantByName,
      );
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<double> calcularTempoAPe(double origemLat, double origemLng, double destinoLat, double destinoLng) async {
    String apiUrl = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$origemLat,$origemLng&destinations=$destinoLat,$destinoLng&mode=walking&key=AIzaSyDTN9yBqoVdrDor1gaBWxQkywlpCS9Wi_o';
    final response = await http.get(Uri.parse(apiUrl));
    print(apiUrl);
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

  // 

  // Adicionar Restaurantes as listas
  Future<void> funcCloseRestaurants(
      double lat, double lng, List<Restaurant> allRestaurants) async {
    for (var restaurant in allRestaurants) {
      double distance = await Geolocator.distanceBetween(
        lat,
        lng,
        restaurant.lat ?? 0,
        restaurant.lng ?? 0,
      );
      double distanciaKm = distance/1000;
      String distanciaFormatada = distanciaKm.toStringAsFixed(1);
      restaurant.distance = distanciaFormatada;
      if (distance <= 2000) {
        // 2 km em metros
        closeRestaurant.add(restaurant);
      } else {
        sugestionRes.add(restaurant);
      }
    }
  }

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
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

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: white,
                  elevation: 0,
                  expandedHeight: MediaQuery.of(context).size.height * 0.1,
                  floating: false,
                  pinned: true,
                  flexibleSpace: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: EdgeInsets.fromLTRB(
                        16, MediaQuery.of(context).size.height * 0.06, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                          height: 46,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              decoration: BoxDecoration(
                                color: lightgrey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextField(
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Quicksand',
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Quicksand',
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                ),
                                onEditingComplete: () async {
                                    await getRestaurantByName(_controller);
                                  },
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            '/location',
                            arguments: restaurants,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: actionYellow,
                            ),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.location_pin,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (index == 0) {
                          return const SizedBox
                              .shrink(); // Espaço vazio para a altura do SliverAppBar
                        } else if (index == 1) {
                          return Section(
                            'Restaurantes Próximos',
                            closeRestaurant,
                            MediaQuery.of(context).size.height * 0.08,
                          );
                        } else if (index == 2) {
                          return Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                            ),
                            child: Section(
                              'Sugestões',
                              sugestionRes,
                              MediaQuery.of(context).size.height * 0.19,
                            ),
                          );
                        } else if (index == 3) {
                          return Section(
                            'No precinho',
                            allRestaurants,
                            MediaQuery.of(context).size.height * 0.23,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      childCount:
                          4, // Número total de seções (incluindo a SliverAppBar)
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
