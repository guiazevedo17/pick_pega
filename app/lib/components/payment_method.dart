import 'package:flutter/material.dart';
import '../styles/color.dart';

class PaymentMethod extends StatelessWidget {
  final String type;
  final bool selected;

  const PaymentMethod(
    this.type,
    this.selected, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: type == 'Crédito'
          ? EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width -
                      (3 * MediaQuery.of(context).size.width * 0.29) -
                      32) /
                  2)
          : EdgeInsets.zero,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.29,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: selected == true ? lightYellow : offWhite,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              type == 'Pix' ? 'assets/icons/pix.png' : 'assets/icons/card.png',
              scale: selected == true ? 0.85 : 1,
              color: black,
            ),
            Padding(
              padding: EdgeInsets.only(top: selected == true ? 12.0 : 10.0),
              child: Text(
                type,
                style: TextStyle(
                    color: black,
                    fontFamily: 'Quicksand',
                    fontSize: selected == true ? 18 : 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
