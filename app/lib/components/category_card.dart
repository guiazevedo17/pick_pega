import 'package:flutter/material.dart';
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
      height: 300,
      color: white,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => CategoryCard(categories[index].name),
      ),
    );
  }

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

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
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: offWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Center(
            child: Text(
              widget.name,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
