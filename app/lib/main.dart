import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
// import 'package:flutter_config/flutter_config.dart';
// import 'package:pick_pega/repositories/restaurants_repository.dart';
import 'package:pick_pega/screens/bag.dart';
import 'package:pick_pega/screens/homepage.dart';
import 'package:pick_pega/screens/order.dart';
import 'package:pick_pega/screens/restaurant_menu.dart';
import 'package:pick_pega/screens/search_restaurant.dart';
// import 'package:provider/provider.dart';

import 'screens/location.dart';
import 'screens/payment.dart';
import 'screens/product_selected.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      initialRoute: '/homepage',
      routes: {
        '/homepage': (context) => const Homepage(),
        '/search_restaurant': (context) => const SearchRestaurant(),
        '/location': (context) => const LocationScreen(),
        '/restaurant_menu': (context) => const RestaurantMenu(),
        '/product_selected': (context) => const ProductSelected(),
        '/bag': (context) => const BagScreen(),
        '/payment': (context) => const Payment(),
        '/order': (context) => const OrderScreen(),
      },
    );
  }
}
