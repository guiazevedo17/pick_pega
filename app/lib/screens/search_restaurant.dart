import 'package:flutter/material.dart';
import 'package:pick_pega/components/restaurant.dart';

import '../components/section.dart';

class SearchRestaurant extends StatefulWidget {
  const SearchRestaurant({Key? key}) : super(key: key);

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  final borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),

          //App Bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Row(
              children: [
                // Logo
                SizedBox(
                    width: 40,
                    height: 46,
                    child: Image.asset('assets/images/logo.png')),

                // Barra de Pesquisa
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: 230,
                    decoration: BoxDecoration(
                        color: const Color(0xFFEAEAEA),
                        borderRadius: BorderRadius.circular(20)),
                    child: const TextField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar...',
                          prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                ),

                // Botão de Localização
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFF8BD36)),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.location_pin,
                      color: Color(0xFFF8F8F8),
                    ),
                  ),
                )
              ],
            ),
          ),

          // Restaurantes Próximos
          const Section('Restaurantes Próximos', [Restaurant()]),

          // space
          const SizedBox(
            height: 50,
          ),

          // Sugestões
          // Section('Sugestões'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
                child: Text(
                  'Sugestões',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: 200,
                    height: 130,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo do Restaurante
                            FittedBox(
                              child: Image.asset('assets/images/sow.png'),
                            ),

                            // Título do Restaurante
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                'Sow',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF333333),
                                ),
                              ),
                            ),

                            // Informações do Restaurante
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 2.0),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 14,
                                  ),
                                ),
                                Text(
                                  '2.3km',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF333333)),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 10, right: 2.0),
                                  child: Icon(
                                    Icons.run_circle_outlined,
                                    size: 14,
                                  ),
                                ),
                                Text(
                                  '20min',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF333333)),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 10, right: 2.0),
                                  child: Icon(
                                    Icons.car_crash_outlined,
                                    size: 14,
                                  ),
                                ),
                                Text(
                                  '5min',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xFF333333)),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ),
                ),
              )
            ],
          ),

          // space
          const SizedBox(
            height: 50,
          ),

          // 'Promoções'
          //Section('No precinho'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 0, 8),
                child: Text(
                  'No precinho',
                  style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: 150,
                    height: 160,
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFE8E8E8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.asset('assets/images/tacos.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'RS 32,00',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF333333),
                              ),
                            ),
                            Text(
                              'RS 20,00',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFF8BD36),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 30,
                              height: 30,
                              child:
                                  Image.asset('assets/images/restaurant.png'),
                            ),
                            const Text(
                              'Naural Drink',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF333333),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 2.0),
                              child: Icon(
                                Icons.location_pin,
                                size: 14,
                              ),
                            ),
                            Text(
                              '0.5km',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF333333)),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
