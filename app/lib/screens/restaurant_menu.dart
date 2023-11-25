import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_pega/components/menu_category.dart';
import 'package:pick_pega/models/navigation_manager.dart';
import 'package:pick_pega/models/product.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../components/category_card.dart';
import '../models/category.dart';
import '../models/restaurant.dart';
import '../models/shopping_bag.dart';

class RestaurantMenu extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantMenu(this.restaurant, {super.key});

  @override
  State<RestaurantMenu> createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  List<Category> categories = [];

  late ShoppingBag shoppingBag;

  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();

    shoppingBag.restaurantPhoto = widget.restaurant.photo;
    shoppingBag.restaurantName = widget.restaurant.name;
    shoppingBag.restaurantId = widget.restaurant.uid;
  }

  Future<List<Category>> getAllCategories() async {
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getRestaurantMenu/${widget.restaurant.uid}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);

      // Zanhas's solution

      final Map<String, dynamic> categoriesData =
          jsonBody['payload']['categories'];

      categoriesData.forEach((category, items) {
        List<Product> products = [];
        if (items is List) {
          for (var item in items) {
            var prod = Product(
              active: item['active'],
              restaurantId: item['restaurantId'],
              category: item['category'],
              itemId: item['itemId'],
              name: item['name'],
              description: item['description'],
              price: item['price'],
              time: item['time'],
              picture: item['picture'],
            );
            products.add(prod);
          }
        }

        var cat = Category(
          name: category,
          products: products,
        );

        categories.add(cat);
      });

      return categories;
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Category>>(
        future: getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Stack(
              children: [
                Center(
                  child: Text('Erro: ${snapshot.error}'),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: actionYellow,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.06,
                        left: 8,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Stack(
              children: [
                const Center(
                  child: Text('Nenhum produto disponível'),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: actionYellow,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.06,
                        left: 8,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
            ;
          } else {
            List<Category> categories = snapshot.data!;

            return Stack(
              children: [
                // Restaurant Menu Content
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: white,
                      elevation: 0,
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * 0.35,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Restaurant Logo
                              Image.network(
                                widget.restaurant.photo,
                                width: 80,
                                height: 80,
                              ),

                              // Restaurant Name
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14.0),
                                child: Text(
                                  widget.restaurant.name,
                                  style: const TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              // Search Bar
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                  decoration: BoxDecoration(
                                      color: lightgrey,
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

                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Operating Information
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(16.0, 14.0, 0, 4),
                                    child: Text(
                                      'Seg - Sex | 06 - 23h',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Quicksand',
                                      ),
                                    ),
                                  ),
                                  Padding(
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      leading: null,
                    ),

                    // Categories List
                      SliverPersistentHeader(
                        delegate: RestaurantCategory(categories: categories),
                        pinned: true,
                      ),
                    

                    // Products List
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return MenuCategory(
                          categories[index].name,
                          categories[index].products,
                        );
                      }, childCount: categories.length),
                    )
                  ],
                ),

                // Return Button
                Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: actionYellow,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.06,
                        left: 8,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),

      // Bag Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/bag');
          NavigationManager.history.add('/bag');
        },
        backgroundColor: actionYellow,
        child: SvgPicture.asset(
          'assets/icons/bag.svg',
          // width: 100,
          // height: 100,
        ),
      ),
    );
  }
}
