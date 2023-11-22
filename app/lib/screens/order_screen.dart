import 'package:flutter/material.dart';
import 'package:pick_pega/components/order_product.dart';
import 'package:pick_pega/models/order.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/shopping_bag.dart';

class OrderScreen extends StatefulWidget {
  final OrderModel order;
  const OrderScreen(
    this.order, {
    super.key,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late ShoppingBag shoppingBag;

  @override
  void initState() {
    super.initState();
    shoppingBag = context.read<ShoppingBag>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Restaurant Info
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
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Natural Drink',
                        style: TextStyle(
                            color: black,
                            fontFamily: 'Quicksand',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // ProgressBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                animation: true,
                animationDuration: 1000,
                width: MediaQuery.of(context).size.width * 0.9,
                lineHeight: 10,
                percent: 0.5,
                barRadius: const Radius.circular(20),
                progressColor: actionYellow,
                backgroundColor: lightYellow,
              ),
            ),

            // Remaining Time
            Text(
              '05:00',
              style: TextStyle(
                  color: black,
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),

            // Code
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  '0127',
                  style: TextStyle(
                    color: actionYellow,
                    fontFamily: 'Quicksand',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Itens List
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: shoppingBag.bag.length,
                    itemBuilder: (context, index) {
                      int qntd = 0;

                      for (var prod in shoppingBag.products) {
                        if (prod == shoppingBag.bag[index]) {
                          qntd++;
                        }
                      }

                      return OrderProduct(shoppingBag.bag[index], qntd);
                    }),
              ),
            ),

            // Order Info
            Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(20),
                  right: Radius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  color: lightgrey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Order Date
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.order.date,
                                style: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.order.time,
                                style: const TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Name
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Nome',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.order.name,
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              // Payment + Time
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Payment
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Pagamento',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.order.payment,
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),

                                  // Time
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Tempo',
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${widget.order.necessaryTime} min',
                                        style: const TextStyle(
                                            fontFamily: 'Quicksand',
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Total Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'RS ${widget.order.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        )
                      ],
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
