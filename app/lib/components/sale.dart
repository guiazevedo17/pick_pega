import 'package:flutter/material.dart';

class Sale extends StatelessWidget {
  const Sale({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.5,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10)),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // Sale Product Picture
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.11,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              'assets/images/tacos.png',
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Sale Details
        const Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Price BEFORE Sale
              Text(
                'RS 32,00',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF333333),
                ),
              ),

              // Price in Sale
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

        // Restaurant Info
        Padding(
          padding: const EdgeInsets.only(top: 4.0, right: 16, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Restaurant Logo
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(
                  'assets/images/restaurant.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Restaurant Name
              const Text(
                'Natural Drink',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF333333),
                ),
              )
            ],
          ),
        ),

        // Distance Info
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: Icon(
                  Icons.location_pin,
                  size: 14,
                ),
              ),
              // Distance
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
