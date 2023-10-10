import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';
import 'package:percent_indicator/percent_indicator.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Restaurant Info
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Restaurant Logo
                  Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/images/restaurant.png',
                      width: 70,
                      height: 70,
                    ),
                  ),

                  // Restaurant Name
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Natural Drink',
                        style: TextStyle(
                            color: black,
                            fontFamily: 'Quicksand',
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // ProgressBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: LinearPercentIndicator(
                alignment: MainAxisAlignment.center,
                animation: true,
                animationDuration: 1000,
                width: MediaQuery.of(context).size.width * 0.9,
                lineHeight: 10,
                percent: 0.5,
                barRadius: const Radius.circular(20),
                progressColor: actionYellow,
                backgroundColor: lightYellow,
              ),
            ),

            // Remaining Time
            Text(
              '05:00',
              style: TextStyle(
                  color: black,
                  fontFamily: 'Quicksand',
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),

            Text(
              '0127',
              style: TextStyle(
                color: actionYellow,
                fontFamily: 'Quicksand',
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
