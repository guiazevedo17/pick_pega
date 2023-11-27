import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';

import '../models/category.dart';

class RestaurantCategory extends SliverPersistentHeaderDelegate {
  final List<Category> categories;
  final ValueChanged<int> onChanged;

  RestaurantCategory({required this.categories, required this.onChanged});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Categories(categories, onChanged, 0);
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

// ignore: must_be_immutable
class Categories extends StatefulWidget {
  final List<Category> categories;

  final ValueChanged<int> onChanged;

  int selectedIndex;

  Categories(this.categories, this.onChanged, this.selectedIndex, {super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant Categories oldWidget) {
    controller.animateTo(80,
        duration: Duration(microseconds: 200), curve: Curves.ease);

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: white,
      padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            widget.onChanged(index);
            setState(() {
              widget.selectedIndex = index;
            });
          },
          child: CategoryCard(
            widget.categories[index].name,
            widget.selectedIndex == index,
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  final String name;
  final bool selected;

  const CategoryCard(this.name, this.selected, {super.key});

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
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: widget.selected == true ? 18 : 16,
                  fontWeight: widget.selected == true
                      ? FontWeight.bold
                      : FontWeight.w600,
                  color: widget.selected == true ? lightBlue : black),
            ),
          ),
        ),
      ),
    );
  }
}
