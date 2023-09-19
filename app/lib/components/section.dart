import 'package:flutter/material.dart';

class Section extends StatefulWidget {
  final String title;

  const Section(this.title, {super.key});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 0, 8),
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Container(
              width: 70,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(100)),
              child: FittedBox(
                child: Image.asset('assets/images/restaurant.png'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
