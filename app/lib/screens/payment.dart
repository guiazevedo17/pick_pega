import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0, left: 8.0),
              width: 48,
              height: 48,
              child: Image.asset('assets/images/buttonBack.png'),
            ),
            Center( // Centralize o texto
              child: Container(
                child: const Text(
                  'Crédito',
                  style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 141),
              child: Container(
                child:  Column(
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
                    const SizedBox(height: 11,),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEAEAEA), // Cor EAEAEA
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Padding lateral de 16px
                        border: OutlineInputBorder( // Borda ao redor do TextField
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,// Borda circular de 8px
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    const Text(
                      'Número',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 11,),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEAEAEA), // Cor EAEAEA
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Padding lateral de 16px
                        border: OutlineInputBorder( // Borda ao redor do TextField
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,// Borda circular de 8px
                        ),
                      ),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
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
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFEAEAEA), // Cor EAEAEA
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Padding lateral de 16px
                                    border: OutlineInputBorder( // Borda ao redor do TextField
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,// Borda circular de 8px
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Expanded(
                          child: Container(
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
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color(0xFFEAEAEA), // Cor EAEAEA
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Padding lateral de 16px
                                    border: OutlineInputBorder( // Borda ao redor do TextField
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderSide: BorderSide.none,// Borda circular de 8px
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text(
                                'Total',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                               Text(
                                'R\$ 20,00',
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),

                          GestureDetector(
                            onTap: () {
                              // Ação do botão
                            },
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
                                  'Confirmar',
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
                        ],
                      ),
                    )

                  ],
                ),

              ),
            )
          ],
        ),
      ),
    );

  }
}
