import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_pega/models/order.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../models/navigation_manager.dart';
import '../models/shopping_bag.dart';
import '../styles/color.dart';
import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';

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
  late TextEditingController _mesaController;
  String? mesa;
  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();
    _nameController = TextEditingController();
    _numberController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
    _mesaController = TextEditingController();
  }

  bool _isCardNumberValid = true;

  bool validateCardNumber() {
    if (_numberController.text.length >= 16) {
      return true;
    }
    return false;
  }

  bool validateExperyDate() {
    if (_expiryDateController.text.length >= 4) {
      return true;
    }
    return false;
  }

  bool validateCVV() {
    if (_cvvController.text.length >= 3) {
      return true;
    }
    return false;
  }

  bool validadeFieldsNull() {
    if (_numberController.text.isEmpty ||
        _cvvController.text.isEmpty ||
        _expiryDateController.text.isEmpty ||
        _nameController.text.isEmpty) {
      return false;
    }
    return true;
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CartaoBancarioInputFormatter()
                      ],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFEAEAEA),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none),
                      ),
                      onEditingComplete: () {
                        if (!validateCardNumber()) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => AlertDialog(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 25),
                              actionsPadding:
                                  const EdgeInsets.fromLTRB(10, 25, 10, 15),
                              icon: Icon(
                                Icons.error,
                                size: 60,
                                color: actionYellow,
                              ),
                              iconPadding: EdgeInsets.all(20),
                              content: const Text(
                                'Campo Número deve ter 16 dígitos',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              actions: [
                                // Cancel
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    elevation: 0,
                                    foregroundColor: actionYellow,
                                    side: BorderSide(color: actionYellow),
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.25,
                                        40),
                                  ),
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              actionsAlignment: MainAxisAlignment.spaceEvenly,
                            ),
                          );
                        }
                      },
                      keyboardType: TextInputType.number,
                    ),
                    // if (!_isCardNumberValid)
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 8.0),
                    //     child: Text(
                    //       'Número do cartão deve ter 16 dígitos',
                    //       style: TextStyle(color: Colors.red),
                    //     ),
                    //   ),
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
                                'Data de Validade',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                              TextField(
                                controller: _expiryDateController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ValidadeCartaoInputFormatter()
                                ],
                                keyboardType: TextInputType.number,
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
                                onEditingComplete: () {
                                  if (!validateExperyDate()) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 20, 25),
                                        actionsPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 25, 10, 15),
                                        icon: Icon(
                                          Icons.error,
                                          size: 60,
                                          color: actionYellow,
                                        ),
                                        iconPadding: EdgeInsets.all(20),
                                        content: const Text(
                                          'Campo Data de Validade deve ter 4 dígitos',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        actions: [
                                          // Cancel
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              foregroundColor: actionYellow,
                                              side: BorderSide(
                                                  color: actionYellow),
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  40),
                                            ),
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                      ),
                                    );
                                  }
                                },
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(4),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                keyboardType: TextInputType.number,
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
                                onEditingComplete: () {
                                  if (!validateCVV()) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => AlertDialog(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 20, 25),
                                        actionsPadding:
                                            const EdgeInsets.fromLTRB(
                                                10, 25, 10, 15),
                                        icon: Icon(
                                          Icons.error,
                                          size: 60,
                                          color: actionYellow,
                                        ),
                                        iconPadding: EdgeInsets.all(20),
                                        content: const Text(
                                          'Campo CVV deve ter 3 ou 4 dígitos',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        actions: [
                                          // Cancel
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: OutlinedButton.styleFrom(
                                              elevation: 0,
                                              foregroundColor: actionYellow,
                                              side: BorderSide(
                                                  color: actionYellow),
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  40),
                                            ),
                                            child: const Text(
                                              'Ok',
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                      ),
                                    );
                                  }
                                },
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
                  print("MESA: $mesa");

                  if (validadeFieldsNull()) {
                    DateTime now = DateTime.now();
                    print("DATETIMENOW: $now");
                    String dataFormatada =
                        now.toIso8601String().substring(0, 23);
                    print("DATETIMENOW: $dataFormatada");

                    String formattedDate =
                        '${now.day}/${now.month}/${now.year}';
                    String formattedTime = '${now.hour}:${now.minute}';

                    shoppingBag.customerName = _nameController.text;
                    shoppingBag.orderDate = formattedDate;
                    shoppingBag.orderHour = formattedTime;

                    String table = _mesaController.text;

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
                    }

                    if (mesa == null) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          actionsOverflowAlignment: OverflowBarAlignment.center,
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 25),
                          actionsPadding:
                              const EdgeInsets.fromLTRB(10, 25, 10, 15),
                          icon: Icon(
                            Icons.error,
                            size: 60,
                            color: actionYellow,
                          ),
                          iconPadding: EdgeInsets.all(20),
                          content: const Text(
                            'Digite  número da sua mesa (o número encontra-se em cima do qrcode): ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            TextField(
                              controller: _mesaController,
                              keyboardType: TextInputType.number,
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
                                  borderSide:
                                      BorderSide.none, // Borda circular de 8px
                                ),
                              ),
                            ),
                            // Ok
                            OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                table = _mesaController.text;
                                var order = OrderModel(
                                    status: 'Em espera',
                                    date: dataFormatada,
                                    time: formattedTime,
                                    name: table,
                                    payment: widget.paymentMethod,
                                    products: shoppingBag.bag,
                                    necessaryTime: totalNecessaryTime,
                                    price: shoppingBag.totalPrice);

                                createOrder(order);

                                Navigator.of(context).pushReplacementNamed(
                                    '/order',
                                    arguments: order);
                                NavigationManager.history.add('/order');
                              },
                              style: OutlinedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: actionYellow,
                                side: BorderSide(color: actionYellow),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.25,
                                    40),
                              ),
                              child: const Text(
                                'Salvar',
                                style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      );
                    }
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 20, 25),
                        actionsPadding:
                            const EdgeInsets.fromLTRB(10, 25, 10, 15),
                        icon: Icon(
                          Icons.error,
                          size: 60,
                          color: actionYellow,
                        ),
                        iconPadding: EdgeInsets.all(20),
                        content: const Text(
                          'Existem campos vazios',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          // Cancel
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: OutlinedButton.styleFrom(
                              elevation: 0,
                              foregroundColor: actionYellow,
                              side: BorderSide(color: actionYellow),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.25, 40),
                            ),
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    );
                  }
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
