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
        );
      }).toList();
      await pegarPosicao();
      print("latitude: $latitude");
      funcCloseRestaurants(latitude!, longitude!, allRestaurants);
      return allRestaurants;
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }

  // Pega posição autal do usuário
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

      restaurant.distance = distance;

      if (distance <= 2000) {
        // 2 km em metros
        closeRestaurant.add(restaurant);
      } else {
        sugestionRes.add(restaurant);
      }
    }
  }

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
                              child: const TextField(
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Quicksand',
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Quicksand',
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                ),
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
