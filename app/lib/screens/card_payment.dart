import 'package:flutter/material.dart';
import 'package:pick_pega/models/order.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/navigation_manager.dart';
import '../models/shopping_bag.dart';
import '../styles/color.dart';
import 'dart:convert';

class CardPayment extends StatefulWidget {
  final String paymentMethod;
  const CardPayment(this.paymentMethod, {Key? key}) : super(key: key);

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  late ShoppingBag shoppingBag;

  late TextEditingController _nameController;
  late TextEditingController _numberController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;

  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
  }

  Future<OrderModel> createOrder(OrderModel order) async {
    final response = await http.post(
      Uri.parse(
          'https://southamerica-east1-pick-pega.cloudfunctions.net/api/addNewOrder/${shoppingBag.restaurantId}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order
          .toJson()), // Converte OrderModel para um mapa antes de codificar para JSON
    );

    if (response.statusCode == 200) {
      print("ENTROU");
      // Se o servidor retornar uma resposta 201 CREATED,
      // então parseie o JSON.
      return OrderModel.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // Se o servidor não retornar uma resposta 201 CREATED,
      // então lance uma exceção.
      throw Exception('Falha ao criar pedido.');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8.0, left: 8.0),
                width: 48,
                height: 48,
                child: Image.asset('assets/images/buttonBack.png'),
              ),
            ),
            Center(
              // Centralize o texto
              child: Text(
                widget.paymentMethod,
                style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nome',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEAEAEA), // Cor EAEAEA
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // Padding lateral de 16px
                        border: OutlineInputBorder(
                          // Borda ao redor do TextField
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none, // Borda circular de 8px
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Número',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 11,
                    ),
                    TextField(
                      controller: _numberController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEAEAEA), // Cor EAEAEA
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // Padding lateral de 16px
                        border: OutlineInputBorder(
                          // Borda ao redor do TextField
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none, // Borda circular de 8px
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Data',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              TextField(
                                controller: _expiryDateController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFEAEAEA), // Cor EAEAEA
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal:
                                          16.0), // Padding lateral de 16px
                                  border: OutlineInputBorder(
                                    // Borda ao redor do TextField
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide
                                        .none, // Borda circular de 8px
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'CVV',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              TextField(
                                controller: _cvvController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: lightgrey, // Cor EAEAEA
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal:
                                          16.0), // Padding lateral de 16px
                                  border: OutlineInputBorder(
                                    // Borda ao redor do TextField
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide
                                        .none, // Borda circular de 8px
                                  ),
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
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'R\$ ${shoppingBag.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Add to Confirm Payment
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();

                  DateTime now = DateTime.now();
                  String formattedDate = '${now.day}/${now.month}/${now.year}';
                  String formattedTime = '${now.hour}:${now.minute}';
                  String name;

                  if (widget.paymentMethod == 'Pix') {
                    name =
                        'No Pix foi tão rápido que não pudemos nos conhecer melhor';
                  } else {
                    name = _nameController.text;
                  }

                  int totalNecessaryTime = shoppingBag.updateTotalTime();

                  int qntd;

                  for (var item in shoppingBag.bag) {
                    qntd = 0;

                    for (var prod in shoppingBag.products) {
                      if (item == prod) {
                        qntd++;
                      }
                    }

                    item.qntd = qntd;
                    print("ITEM: ${item.name}    QUANT: ${item.qntd}");
                  }

                  var order = OrderModel(
                      status: 'Em espera',
                      date: formattedDate,
                      time: formattedTime,
                      name: name,
                      payment: widget.paymentMethod,
                      products: shoppingBag.bag,
                      necessaryTime: totalNecessaryTime,
                      price: shoppingBag.totalPrice);

                  createOrder(order);

                  Navigator.of(context).pushNamed('/order', arguments: order);
                  NavigationManager.history.add('/order');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
                  backgroundColor: actionYellow,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
