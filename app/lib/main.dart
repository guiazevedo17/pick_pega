import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pick_pega/repositories/restaurants_repository.dart';
import 'package:pick_pega/screens/payment.dart';
import 'package:pick_pega/screens/product_selected.dart';
import 'package:pick_pega/screens/search_restaurant.dart';
import 'package:provider/provider.dart';

import 'screens/location.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(
    ChangeNotifierProvider<RestaurantsRepository>(
      create: (context) => RestaurantsRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pick Pega',
      debugShowCheckedModeBanner: false,
      initialRoute: '/payment',
      routes: {
        '/search_restaurant': (context) => const SearchRestaurant(),
        '/location': (context) => const LocationScreen(),
        '/product_selected': (context) => const ProductSelected(),
        '/payment': (context) => const Payment()
      },
    );
  }
}
