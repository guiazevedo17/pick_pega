import 'package:flutter/material.dart';
import 'package:pick_pega/components/menu_product.dart';
import 'package:pick_pega/models/product.dart';
import 'package:pick_pega/styles/color.dart';

class MenuCategory extends StatelessWidget {
  final String title;
  final List<Product> products;

  const MenuCategory(
    this.title,
    this.products, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title of the Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
          child: Text(
            title,
            style: TextStyle(
              color: black,
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // List of Widgets
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () => Navigator.of(context)
                    .pushNamed('/product_selected', arguments: products[index]),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: MenuProduct(products[index]),
                ));
          },
        )
      ],
    );
  }
}
