import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_config/flutter_config.dart';
// import 'package:pick_pega/repositories/restaurants_repository.dart';
import 'package:pick_pega/screens/bag.dart';
import 'package:pick_pega/screens/homepage.dart';
import 'package:pick_pega/screens/order.dart';
import 'package:pick_pega/screens/restaurant_menu.dart';
import 'package:pick_pega/screens/search_restaurant.dart';
// import 'package:provider/provider.dart';

import 'screens/location.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(
      // ChangeNotifierProvider<RestaurantsRepository>(
      //   create: (context) => RestaurantsRepository(),
      //   child: const MyApp(),
      // ),
      const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pick Pega',
      debugShowCheckedModeBanner: false,
      initialRoute: '/order',
      routes: {
        '/homepage': (context) => const Homepage(),
        '/search_restaurant': (context) => const SearchRestaurant(),
        '/location': (context) => const LocationScreen(),
        '/restaurant_menu': (context) => const RestaurantMenu(),
        '/bag': (context) => const BagScreen(),
        '/order': (context) => const OrderScreen(),
      },
    );
  }
}
