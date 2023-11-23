import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_pega/components/bag_product.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:provider/provider.dart';

import '../components/payment_method.dart';
import '../models/shopping_bag.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  late ShoppingBag shoppingBag;

  int selectedIndex = -1;

  final List<String> paymentMethods = ['Pix', 'Crédito', 'Débito'];

  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingBag>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Stack(
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
                    margin: const EdgeInsets.only(left: 8, top: 8),
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
                ),
              ),

              // Clear Bag Button
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 20, 25),
                        actionsPadding:
                            const EdgeInsets.fromLTRB(10, 25, 10, 15),
                        icon: SvgPicture.asset(
                          'assets/icons/bag-error.svg',
                          width: 100,
                          height: 100,
                        ),
                        iconPadding: EdgeInsets.all(20),
                        content: const Text(
                          'Quer mesmo LIMPAR a Sacola?',
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
                              'Cancelar',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          // Remove Item from Bag
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                shoppingBag.clearBag();
                              });
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                foregroundColor: white,
                                backgroundColor: deleteRed,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.25,
                                    40)),
                            child: const Text(
                              'Limpar',
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
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(
                      right: 8,
                      top: 8,
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
              ),

              // Content of Page
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08),
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
                            child: Image.network(
                              shoppingBag.restaurantPhoto,
                              width: 70,
                              height: 70,
                            ),
                          ),

                          // Restaurant Name
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                shoppingBag.restaurantName,
                                style: const TextStyle(
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
                                  itemCount: shoppingBag.bag.length,
                                  itemBuilder: (context, index) {
                                    return BagProduct(shoppingBag.bag[index]);
                                  },
                                ),
                              ),

                              // Necessery Time
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 4.0),
                                      child: Icon(
                                        Icons.timer_outlined,
                                        color: lightBlue,
                                        size: 18,
                                      ),
                                    ),
                                    Text(
                                      '${shoppingBag.updateTotalTime()} min',
                                      style: const TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // Payment Methods
                              // Title
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

                              // Methods
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: paymentMethods.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        child: PaymentMethod(
                                          paymentMethods[index],
                                          selectedIndex == index,
                                        ));
                                  },
                                ),
                              )
                            ],
                          ),
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
                            'R\$ ${shoppingBag.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
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
                          if (selectedIndex > -1) {
                            Navigator.of(context).pushNamed('/card_payment',
                                arguments: paymentMethods[selectedIndex]);
                          }
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
        ),
      ),
    );
  }
}
