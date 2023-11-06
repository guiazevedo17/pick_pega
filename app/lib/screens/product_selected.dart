import 'package:flutter/material.dart';

import '../styles/color.dart';

class ProductSelected extends StatefulWidget {
  const ProductSelected({Key? key}) : super(key: key);

  @override
  State<ProductSelected> createState() => _ProductSelectedState();
}

class _ProductSelectedState extends State<ProductSelected> {
  final int _price = 10;
  int _counter = 0; // Declaração da variável _counter

  String _priceShowed = '0';

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _updatePrice() {
    setState(() {
      _priceShowed = (_price * _counter).toString();
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
              Container(
                  height: MediaQuery.of(context).size.height * 0.315,
                  child: Image.asset('assets/images/productSelected.png',
                      fit: BoxFit.cover)),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 8.0, left: 8.0),
                    width: 48,
                    height: 48,
                    child: Image.asset('assets/images/buttonBack.png')),
              )
            ]),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 13.0),
              child: Text(
                'R\$ 10,00',
                style: TextStyle(
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
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
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
                            'Pastel de Calabresa',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),

                          // Product Description
                          Text(
                            'Aproximadamente 300 g',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      // Ingredientes
                      Column(
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
                    const Text(
                      '10 min',
                      style: TextStyle(
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
                    'R\$ $_priceShowed',
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
                  Navigator.of(context).pushNamed('/bag');
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
