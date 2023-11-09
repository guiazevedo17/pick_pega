import 'package:flutter/material.dart';
import 'package:pick_pega/components/close_restaurant.dart';
import 'package:pick_pega/components/sale.dart';
import 'package:pick_pega/components/sugestion.dart';
import 'package:pick_pega/styles/color.dart';

import '../models/restaurant.dart';

class Section extends StatelessWidget {
  final String title;
  final List restaurants;

  final double size;

  const Section(this.title, this.restaurants, this.size,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title of the Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
          child: Text(
            title,
            style: TextStyle(
              color: black,
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // List of Widgets
        SizedBox(
          height: size,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              if (size == MediaQuery.of(context).size.height * 0.08) {
                return GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed('/restaurant_menu', arguments: restaurants[index]),
                  child: CloseRestaurant(restaurants[index].photo),
                );
              } else if (size == MediaQuery.of(context).size.height * 0.19) {
                return Sugestion(restaurants[index]);
              } else {
                return const Sale();
              }
            },
          ),
        )
      ],
    );
  }
}
