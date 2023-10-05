import 'package:flutter/material.dart';
import '../styles/color.dart';

class PaymentMethod extends StatelessWidget {
  final String image;
  final String type;

  const PaymentMethod(
    this.image,
    this.type, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.29,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
          color: offWhite, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              type,
              style: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
