import 'package:flutter/material.dart';

class CloseRestaurant extends StatelessWidget {
  const CloseRestaurant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: FittedBox(
        child: Image.asset('assets/images/restaurant.png'),
      ),
    );
  }
}
