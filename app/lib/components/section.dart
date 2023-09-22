import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget widget;
  final double size;

  const Section(this.title, this.widget, this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title of the Section
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // List of Widgets
        SizedBox(
          height: size,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 16),
            itemBuilder: (context, index) => widget,
          ),
        )
      ],
    );
  }
}
