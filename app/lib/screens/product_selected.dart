import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
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

  late ShoppingBag bag;

  @override
  void initState() {
    super.initState();
    bag = context.read<ShoppingBag>();
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(alignment: Alignment.topLeft, children: [
              SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.315,
                  child:
                      Image.network(widget.product.picture, fit: BoxFit.cover)),
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
                  borderRadius: BorderRadius.circular(20), color: actionYellow),
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
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          // Product Description
                          Text(
                            widget.product.description,
                            style: const TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      // Ingredientes
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Ingredientes Title
                          Text(
                            'Ingredientes',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          // Ingredientes Description
                          Text(
                            'Calabresa, Ovo, ...',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                            ),
                          ),
                        ],
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

                  for(int i = 0; i < _counter; i++){
                    bag.addToBag(widget.product);
                  }

                  print('Sacola de Produtos - ${bag.products}');

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => AlertDialog(
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
                        // Okay
                        IconButton(
                          onPressed: () {
                            // Pop to the Product Selected Screen
                            Navigator.of(context).pop();

                            // Pop to the Restaurant Menu Screen
                            Navigator.of(context).pop();
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
                  minimumSize: Size(MediaQuery.of(context).size.width, 50),
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
      ),
    );
  }
}
