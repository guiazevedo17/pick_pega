import 'package:flutter/material.dart';
import 'package:pick_pega/components/sale.dart';

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
      body: SizedBox(
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

                    // Location Button
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

            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Section('Restaurantes Próximos', Restaurant(),
                        MediaQuery.of(context).size.height * 0.08),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Section('Sugestões', Sugestion(),
                          MediaQuery.of(context).size.height * 0.18),
                    ),
                    Section('No precinho', Sale(),
                        MediaQuery.of(context).size.height * 0.23)
                  ],
                ),
              ),
            )

            // Content / Sections
          ],
        ),
      ),
    );
  }
}
