import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';
import 'package:pick_pega/styles/color.dart';

class MenuProduct extends StatelessWidget {
  final Product product;

  const MenuProduct(
    this.product, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: offWhite, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: Text(
                      product.description,
                      style: const TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Image.asset(
                          'assets/icons/money.png',
                          scale: 1.2,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      Text(
                        '${product.price}',
                        style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 13,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0, right: 4.0),
                        child: Image.asset(
                          'assets/icons/timer.png',
                          scale: 1.2,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      Text(
                        '${product.time}',
                        style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Image.network(
                  product.picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
