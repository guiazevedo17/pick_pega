// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

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
      backgroundColor: Color(0xFFF8F8F8),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
                    width: 270,
                    decoration: BoxDecoration(
                        color: Color(0xFFEAEAEA),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
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
                      color: Color(0xFFF8BD36)),
                  child: SizedBox(
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
          Section('Restaurantes Próximos'),

          // Sugestões
          Section('Sugestões'),

          // 'Promoções'
          Section('No precinho'),
        ],
      ),
    );
  }
}
