import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:provider/provider.dart';

import '../models/shopping_bag.dart';

class BagProduct extends StatefulWidget {
  final Product product;

  const BagProduct(
    this.product, {
    super.key,
  });

  @override
  State<BagProduct> createState() => _BagProductState();
}

class _BagProductState extends State<BagProduct> {
  late int qntd = 0;
  late ShoppingBag shoopingBag;

  @override
  void initState() {
    super.initState();
    shoopingBag = context.read<ShoppingBag>();

    for (var prod in shoopingBag.products) {
      if (prod == widget.product) {
        qntd++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: offWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.network(
                  widget.product.picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'R\$ ${widget.product.price}',
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: actionYellow),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() {
                          qntd--;
                        }),
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
                        qntd.toString(),
                        style: TextStyle(
                            fontFamily: 'Quicksand',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                      GestureDetector(
                        onTap: () => setState(() {
                          qntd++;
                        }),
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
            ),
          )
        ],
      ),
    );
  }
}
