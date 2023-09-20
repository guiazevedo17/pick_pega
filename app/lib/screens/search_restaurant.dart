import 'package:flutter/material.dart';

import 'package:pick_pega/components/promo.dart';
import 'package:pick_pega/components/restaurant.dart';
import 'package:pick_pega/components/sugestion.dart';

import '../components/section.dart';

class SearchRestaurant extends StatefulWidget {
  const SearchRestaurant({Key? key}) : super(key: key);

  @override
  State<SearchRestaurant> createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Row(
                children: [
                  // Logo
                  SizedBox(
                      width: 40,
                      height: 46,
                      child: Image.asset('assets/images/logo.png')),

                  // Barra de Pesquisa
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 10.0, 0),
                      child: Container(
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
          ),

          // Restaurantes Próximos
          const Section('Restaurantes Próximos', Restaurant()),

          // space
          const SizedBox(
            height: 50,
          ),

          // Sugestões
          const Section('Sugestões', Sugestion()),

          // space
          const SizedBox(
            height: 50,
          ),

          // 'Promoções'
          //Section('No precinho'),
          const Section('Sugestões', Promo()),
        ],
      ),
    );
  }
}
