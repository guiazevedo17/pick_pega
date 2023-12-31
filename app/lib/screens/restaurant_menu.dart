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
  final scrollCrontroller = ScrollController();

  List<Category> categories = [];

  late ShoppingBag shoppingBag;
  Product? searchItem;

  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();

    shoppingBag.restaurantPhoto = widget.restaurant.photo;
    shoppingBag.restaurantName = widget.restaurant.name;
    shoppingBag.restaurantId = widget.restaurant.uid;

    scrollCrontroller.addListener(() {
      updateCategoryIndexOnScroll(scrollCrontroller.offset);
    });
  }

  Future<void> getItemByName(TextEditingController controller) async {
    String nome = controller.text;
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getItemByName/$nome/${widget.restaurant.name}/${widget.restaurant.uid}');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);

      // Acesse o valor da chave 'payload' no JSON
      final payload = jsonBody['payload'];

      // Agora, 'payload' é uma lista de elementos
      searchItem = Product(
        active: payload[0]['active'],
        restaurantId: payload[0]['restaurantId'],
        category: payload[0]['category'],
        itemId: payload[0]['itemId'],
        name: payload[0]['name'],
        description: payload[0]['description'],
        price: payload[0]['price'],
        time: payload[0]['time'],
        picture: payload[0]['picture'],
      );
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
    }
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

  scrollTo(int index) {
    if (selectedCategoryIndex != index) {
      int totalItens = 0;

      for (var i = 0; i < index; i++) {
        totalItens += categories[index].products.length;
      }

      scrollCrontroller.animateTo(
          MediaQuery.of(context).size.height * 0.35 +
              (totalItens * 110) +
              (42 * index) -
              kToolbarHeight,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease);
    }
  }

  List<double> breakPoints = [];

  void createBreakPoints() {
    double firstBreakPoint = MediaQuery.of(context).size.height * 0.35 +
        42 +
        (110 * categories[0].products.length);

    breakPoints.add(firstBreakPoint);

    for (var i = 0; i < categories.length; i++) {
      double breakPoint =
          breakPoints.last + 42 + (110 * categories[0].products.length);
      breakPoints.add(breakPoint);
    }
  }

  void updateCategoryIndexOnScroll(double offset) {
    for (var i = 0; i < categories.length; i++) {
      if (i == 0) {
        if ((offset < breakPoints.first) & (selectedCategoryIndex != 0)) {
          setState(() {
            selectedCategoryIndex = 0;
          });
        }
      } else if ((breakPoints[i - 1] <= offset) & (offset < breakPoints[i])) {
        if (selectedCategoryIndex != i) {
          setState(() {
            selectedCategoryIndex = i;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
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
                CustomScrollView(
                  controller: scrollCrontroller,
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
                              ClipOval(
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Image.network(
                                    widget.restaurant.photo,
                                    fit: BoxFit.cover,
                                  ),
                                ),
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
                                    fontWeight: FontWeight.bold,
                                  ),
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

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Operating Information
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(16.0, 14.0, 0, 4),
                                    child: Text(
                                      '${widget.restaurant.openDays} | ${widget.restaurant.openHours}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Quicksand',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.restaurant.distance.toString()} km ',
                                          style: const TextStyle(
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
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/menu.svg',
                              width: 100,
                              height: 100,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                'Cardápio fora do ar ...',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: lightBlue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
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
            categories = snapshot.data!;

            return Stack(
              children: [
                // Restaurant Menu Content
                CustomScrollView(
                  controller: scrollCrontroller,
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

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Operating Information
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(16.0, 14.0, 0, 4),
                                    child: Text(
                                      '${widget.restaurant.openDays} | ${widget.restaurant.openHours}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Quicksand',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 4.0),
                                          child: Icon(
                                            Icons.location_on,
                                            size: 14,
                                          ),
                                        ),
                                        Text(
                                          '${widget.restaurant.distance.toString()} km ',
                                          style: const TextStyle(
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
                      delegate: RestaurantCategory(
                        categories: categories,
                        onChanged: scrollTo,
                      ),
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
