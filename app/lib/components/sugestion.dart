import 'package:flutter/material.dart';

class Sugestion extends StatelessWidget {
  const Sugestion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 130,
      decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Logo do Restaurante
          FittedBox(
            child: Image.asset('assets/images/sow.png'),
          ),

          // Título do Restaurante
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Sow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
          ),

          // Informações do Restaurante
          const Row(
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
                '2.3km',
                style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 2.0),
                child: Icon(
                  Icons.run_circle_outlined,
                  size: 14,
                ),
              ),
              Text(
                '20min',
                style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 2.0),
                child: Icon(
                  Icons.car_crash_outlined,
                  size: 14,
                ),
              ),
              Text(
                '5min',
                style: TextStyle(fontSize: 12, color: Color(0xFF333333)),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
