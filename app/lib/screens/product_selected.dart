import 'package:flutter/material.dart';

import '../styles/color.dart';

class ProductSelected extends StatefulWidget {
  const ProductSelected({Key? key}) : super(key: key);

  @override
  State<ProductSelected> createState() => _ProductSelectedState();
}

class _ProductSelectedState extends State<ProductSelected> {
  int _counter = 0; // Declaração da variável _counter

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
                      onTap: () => _decrementCounter(),
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
                      onTap: () => _incrementCounter(),
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

            // Container(
            //   width: 120,
            //   height: 25,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: const Color(0xFFF8BD36),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(0.2),
            //         spreadRadius: 0,
            //         blurRadius: 2,
            //         offset: const Offset(0, 2),
            //       ),
            //     ],
            //   ),

            //   child: Row(
            //     mainAxisSize: MainAxisSize.max,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // Minus
            //       IconButton(
            //         icon: const Icon(Icons.remove,
            //             size: 13,
            //             // Defina o tamanho do ícone desejado
            //             color: Colors.white),
            //         onPressed: () {
            //           _decrementCounter();
            //         },
            //       ),
            //       // Qntd
            //       Text(
            //         '$_counter',
            //         style: const TextStyle(
            //           fontFamily: 'Quicksand',
            //           fontSize: 13,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.white,
            //         ),
            //       ),
            //       // Add
            //       IconButton(
            //         icon: const Icon(Icons.add,
            //             size: 13,
            //             // Defina o tamanho do ícone desejado
            //             color: Colors.white),
            //         onPressed: () {
            //           _incrementCounter();
            //         },
            //       ),
            //     ],
            //   ),
            // ),

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
            const Text(
              'R\$ 20,00',
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
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
