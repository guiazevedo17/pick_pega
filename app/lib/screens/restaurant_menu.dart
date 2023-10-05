import 'package:flutter/material.dart';

import '../components/category.dart';
// import '../components/menu_product.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color(0xFFF8BD36),
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                left: 8,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Restaurant Logo
                Image.asset(
                  'assets/images/restaurant.png',
                  width: 80,
                  height: 80,
                ),

                // Restaurant Name
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(
                    'Natural Drink',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                        color: const Color(0xFFEAEAEA),
                        borderRadius: BorderRadius.circular(20)),
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Operating Information
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 14.0, 0, 4),
                      child: Text(
                        'Seg - Sex | 06 - 23h',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.location_on,
                              size: 14,
                            ),
                          ),
                          Text(
                            '1.5 km ',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Quicksand',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Categories List
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 16),
                          itemBuilder: (context, index) =>
                              const Category('Salgados'),
                        ),
                      ),
                    ),

                    // Products List
                    // Category Name
                    // const Text(
                    //   'Salgados',
                    //   style: TextStyle(
                    //       fontFamily: 'Quicksand',
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.bold),
                    // ),

                    // Category Products

                    // Product
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
