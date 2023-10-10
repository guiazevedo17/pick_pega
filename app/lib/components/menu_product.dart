import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';

class MenuProduct extends StatelessWidget {
  const MenuProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: offWhite, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pastel de Calabresa',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 8.0),
                    child: Text(
                      'Aprox. 300g',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Image.asset(
                          'assets/icons/money.png',
                          scale: 1.2,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      const Text(
                        'RS 10,00',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 13,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0, right: 4.0),
                        child: Image.asset(
                          'assets/icons/timer.png',
                          scale: 1.2,
                          width: 16,
                          height: 16,
                        ),
                      ),
                      const Text(
                        '10 min',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: Image.asset(
                  'assets/images/pastel.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
