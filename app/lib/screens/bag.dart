import 'package:flutter/material.dart';
import 'package:pick_pega/components/bag_product.dart';
import 'package:pick_pega/styles/color.dart';

import '../components/payment_method.dart';

class BagScreen extends StatelessWidget {
  const BagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          // Exit Bag Button
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
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                  left: 8,
                ),
                decoration: BoxDecoration(
                  color: actionYellow,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: white,
                  size: 20,
                ),
              ),
            ),
          ),

          // Empty Bag Button
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.06,
                right: 8,
              ),
              decoration: BoxDecoration(
                color: actionYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.delete_outline_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Content of Page
          Container(
            width: MediaQuery.of(context).size.width,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Restaurant
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Restaurant Logo
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/images/restaurant.png',
                          width: 70,
                          height: 70,
                        ),
                      ),

                      // Restaurant Name
                      const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Natural Drink',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Itens + Payment
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24.0,
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                      // color: Colors.grey.shade300,
                      width: double.infinity,
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Itens
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Itens',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Itens List
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) =>
                                  const BagProduct(),
                            ),
                          ),

                          // Necessery Time
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    Icons.timer_outlined,
                                    color: lightBlue,
                                    size: 18,
                                  ),
                                ),
                                const Text(
                                  '10 min',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Payment Methods
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Pagamento',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PaymentMethod('assets/icons/pix.png', 'Pix'),
                              PaymentMethod('assets/icons/card.png', 'Crédito'),
                              PaymentMethod('assets/icons/card.png', 'Débito'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Total Price
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'RS 26,00',
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                // Finish Shopping Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/payment');
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
                      'Finalizar Compra',
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
        ],
      ),
    );
  }
}
