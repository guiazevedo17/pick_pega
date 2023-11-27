import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';

import '../models/restaurant.dart';

class Sugestion extends StatelessWidget {
  final Restaurant restaurant;

  const Sugestion(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      height: MediaQuery.of(context).size.height * 0.19,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          color: offWhite, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Restaurant Logo
            SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                restaurant.photo,
                fit: BoxFit.cover,
              ),
            ),

            // Restaurant Name
            Text(
              restaurant.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),

            // Restaurant Infos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Distance km
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 2.0),
                      child: Icon(
                        Icons.location_pin,
                        size: 14,
                      ),
                    ),
                    Text(
                      '${restaurant.distance} km',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF333333)),
                    ),
                  ],
                ),

                // Walking Time
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8, right: 2.0),
                      child: Icon(
                        Icons.run_circle_outlined,
                        size: 14,
                      ),
                    ),
                    Text(
                      '${restaurant.walking} min',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF333333)),
                    ),
                  ],
                ),

                // Driving Time
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8, right: 2.0),
                      child: Icon(
                        Icons.car_crash_outlined,
                        size: 14,
                      ),
                    ),
                    Text(
                      '${restaurant.driving} min',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF333333)),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
