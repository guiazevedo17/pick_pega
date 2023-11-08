import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';
import 'package:pick_pega/styles/color.dart';

import '../models/category.dart';

class RestaurantCategory extends SliverPersistentHeaderDelegate {
  final List<Category> categories;
  // final ValueChanged<int> onChanged;
  // final int selectedIndex;

  RestaurantCategory({required this.categories});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: white,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryCard(categories[index].name!),
      ),
    );
  }

  @override
  double get maxExtent => 35;

  @override
  double get minExtent => 35;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CategoryCard extends StatefulWidget {
  final String name;
  // final onChanged;
  // final selectedIndex;

  const CategoryCard(this.name, {super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: offWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          widget.name,
          style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
