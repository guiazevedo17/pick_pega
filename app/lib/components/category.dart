import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';

class Category extends StatelessWidget {
  final String name;

  const Category(this.name, {super.key});

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
          name,
          style: const TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
