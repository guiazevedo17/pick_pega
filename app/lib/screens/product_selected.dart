import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_pega/models/navigation_manager.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/address.dart';
import '../models/product.dart';
import '../models/restaurant.dart';
import '../models/shopping_bag.dart';
import '../styles/color.dart';

class ProductSelected extends StatefulWidget {
  final Product product;

  const ProductSelected(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductSelected> createState() => _ProductSelectedState();
}

class _ProductSelectedState extends State<ProductSelected> {
  int _counter = 1; // Declaração da variável _counter

  late double _priceShowed = widget.product.price;

  late ShoppingBag shoppingBag;
  late Restaurant restaurant;
  String? telaAnterior = NavigationManager.getPreviousScreen();

  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();
  }

  Future<Restaurant> getRestaurant(String uid) async {
    final uri = Uri.parse(
        'https://southamerica-east1-pick-pega.cloudfunctions.net/api/getRestaurantById/$uid');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse o JSON a partir do corpo da resposta
      final jsonBody = json.decode(response.body);
      //print("jsonBody: $jsonBody");
      // Acesse o valor da chave 'payload' no JSON
      final payload = jsonBody['payload'];

      restaurant = Restaurant(
        uid: jsonBody['uid'],
        name: jsonBody['name'],
        category: jsonBody['category'],
        address: Address(
            zip: jsonBody['address[zip]'],
            number: jsonBody['address[number]'],
            uf: jsonBody['address[uf]'],
            city: jsonBody['address[city]'],
            street: jsonBody['address[street]'],
            neighborhood: jsonBody['address[neighborhood]']),
        lat: jsonBody['lat'],
        lng: jsonBody['lng'],
        photo: jsonBody['photo'],
      );
    } else {
      // Se a solicitação falhar, você pode lidar com o erro aqui.
      print('Request failed with status: ${response.statusCode}');
    }

    return restaurant;
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) _counter--;
    });
  }

  void _updatePrice() {
    setState(() {
      _priceShowed = widget.product.price * _counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Restaurant>(
        future: getRestaurant(widget.product.restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Restaurante não encontrado.'));
          } else {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(alignment: Alignment.topLeft, children: [
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.315,
                        child: Image.network(widget.product.picture,
                            fit: BoxFit.cover)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 8.0, left: 8.0),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: actionYellow,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: white,
                          size: 20,
                        ),
                      ),
                    )
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      'R\$ ${widget.product.price}',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: actionYellow),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _decrementCounter();
                              _updatePrice();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: Icon(
                                Icons.remove,
                                color: white,
                                size: 16,
                              ),
                            ),
                          ),
                          Text(
                            _counter.toString(),
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                          GestureDetector(
                            onTap: () {
                              _incrementCounter();
                              _updatePrice();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6.0),
                              child: Icon(
                                Icons.add,
                                color: white,
                                size: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  // Product Information
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.0,
                          MediaQuery.of(context).size.height * 0.06, 16.0, 0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                widget.product.name,
                                style: const TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            // Product Description
                            Text(
                              widget.product.description,
                              style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Time to Prepare
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Image.asset(
                              'assets/images/timer.png',
                              width: 18,
                              height: 18,
                            ),
                          ),
                          Text(
                            '${widget.product.time} min',
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Total Price
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ ${_priceShowed.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  // Add to Bag Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        for (int i = 0; i < _counter; i++) {
                          shoppingBag.addToBag(widget.product);
                        }

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 25),
                            actionsPadding:
                                const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            icon: SvgPicture.asset(
                              'assets/icons/bag-add.svg',
                              width: 100,
                              height: 100,
                            ),
                            content: const Text(
                              'Produto adicionado a Sacola',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              //if(NavigationManager.getPreviousScreen() == 'RestaurantMenu')

                              // Okay
                              IconButton(
                                onPressed: () async {
                                  print(telaAnterior);

                                  if (telaAnterior == '/search_restaurant') {
                                    print('entrou no search');
                                    Navigator.of(context)
                                        .pop(); // Sai do Alert Dialog

                                    // Buscar restaurante por restaurantId, como no QR Code


                                    if (restaurant != null) {
                                      Navigator.of(context).pushNamed(
                                        '/restaurant_menu',
                                        arguments: restaurant,
                                      );
                                    }

                                    NavigationManager.history
                                        .add('/restaurant_menu');
                                    // Redireciona para tela do restaurante correspondente ao produto
                                  } else {
                                    // Pop to the Product Selected Screen
                                    Navigator.of(context).pop();

                                    // Pop to the Restaurant Menu Screen
                                    Navigator.of(context).pop();
                                  }
                                },
                                icon: Icon(
                                  Icons.done,
                                  color: actionYellow,
                                ),
                              )
                            ],
                            actionsAlignment: MainAxisAlignment.center,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 50),
                        backgroundColor: actionYellow,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      child: const Text(
                        'Adicionar ao Carrinho',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}