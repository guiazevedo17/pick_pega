import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';

class Sale extends StatelessWidget {
  const Sale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          color: offWhite, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Sale Product Picture
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.11,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                'assets/images/tacos.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Sale Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Sale Prices
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Price BEFORE Sale
                      Text(
                        'RS 32,00',
                        style: TextStyle(
                          fontSize: 12,
                          color: black,
                        ),
                      ),

                      // Price in Sale
                      Text(
                        'RS 20,00',
                        style: TextStyle(
                          fontSize: 16,
                          color: actionYellow,
                        ),
                      )
                    ],
                  ),

                  // Restaurant Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Restaurant Logo
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          'assets/images/restaurant.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Restaurant Name
                      Text(
                        'Natural Drink',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12,
                          color: black,
                        ),
                      )
                    ],
                  ),

                  // Distance Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(
                          Icons.location_pin,
                          size: 14,
                          color: black,
                        ),
                      ),
                      // Distance
                      Text(
                        '0.5km',
                        style: TextStyle(
                          fontSize: 12,
                          color: black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )

          // Sale Details
        ],
      ),
    );
  }
}
