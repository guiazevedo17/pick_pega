import 'package:flutter/material.dart';
import 'package:pick_pega/styles/color.dart';

import '../models/navigation_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightYellow,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // General Container
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.22,
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: white,
              ),

              // Container Content
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Logo
                    ClipRRect(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 60,
                        height: 70,
                      ),
                    ),

                    // Texts
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bem - vindo',
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Quicksand'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                'Sem tempo, irmão?',
                                style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: 18,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Text(
                              'Sem problemas, cola com a gente que é sucesso',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 16,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // QR Code Button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/qrcode');
                            // NavigationManager.history.add('/qrode');
                          },
                          child: Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: actionYellow,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // QR Code Icon
                                Icon(
                                  Icons.qr_code,
                                  color: white,
                                ),

                                Text(
                                  'QR Code',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // Search Button
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/search_restaurant');
                            NavigationManager.history.add('/search_restaurant');

                          },
                          child: Container(
                            width: 100,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: actionYellow,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // QR Code Icon
                                Icon(
                                  Icons.search,
                                  color: white,
                                ),

                                Text(
                                  'Buscar',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
