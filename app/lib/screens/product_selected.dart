import 'package:flutter/material.dart';

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
      if(_counter > 0)
        _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> ingredientes = [
      'Calabresa',
      'Queijo',
      'Cebola',
      'Tomate',
      'Molho de tomate'
    ];

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
                onTap: () {},
                child: Container(
                    margin: EdgeInsets.only(top: 8.0, left: 10.0),
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
              width: 120,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF8BD36),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove,
                        size: 13,
                        // Defina o tamanho do ícone desejado
                        color: Colors.white),
                    onPressed: () {
                      _decrementCounter();
                    },
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add,
                        size: 13,
                        // Defina o tamanho do ícone desejado
                        color: Colors.white),
                    onPressed: () {
                      _incrementCounter();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 25, top: 56),
              child: Container(
                alignment: Alignment.topLeft,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pastel de Calabresa',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      // Para limitar a altura ao conteúdo
                      itemCount: ingredientes.length,
                      // Substitua "ingredientes" pela sua lista de ingredientes
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                          ingredientes[index], // Obtém o ingrediente da lista
                          style: const TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Image.asset(
                      'assets/images/timer.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  const Text(
                    '10 min',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'R\$ 20,00',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    // Ação do botão
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 12, bottom: 16, left: 16, right: 16),
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFFF8BD36),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 2,
                            offset: Offset(0, 2),
                          ),
                        ], // Cor de fundo laranja
                      ),
                      child: const Center(
                        child: Text(
                          'Adicionar ao carrinho',
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
