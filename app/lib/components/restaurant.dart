import 'package:flutter/material.dart';

class Restaurant extends StatelessWidget {
  const Restaurant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: FittedBox(
        child: Image.asset('assets/images/restaurant.png'),
      ),
    );
  }
}
