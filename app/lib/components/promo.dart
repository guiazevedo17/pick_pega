import 'package:flutter/material.dart';

class Promo extends StatelessWidget {
  const Promo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 160,
      decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Image.asset('assets/images/tacos.png'),
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'RS 32,00',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF333333),
                ),
              ),
              Text(
                'RS 20,00',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFF8BD36),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset('assets/images/restaurant.png'),
              ),
              const Text(
                'Naural Drink',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF333333),
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 2.0),
                child: Icon(
                  Icons.location_pin,
                  size: 14,
                ),
              ),
              Text(
                '0.5km',
                style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
