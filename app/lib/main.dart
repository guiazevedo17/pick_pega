import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pick_pega/models/restaurant.dart';
import 'firebase_options.dart';
import 'package:pick_pega/screens/bag.dart';
import 'package:pick_pega/screens/homepage.dart';
import 'package:pick_pega/screens/order.dart';
import 'package:pick_pega/screens/restaurant_menu.dart';
import 'package:pick_pega/screens/search_restaurant.dart';
import 'models/product.dart';
import 'screens/location.dart';
import 'screens/payment.dart';
import 'screens/product_selected.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FlutterConfig.loadEnvVariables();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(host: 'localhost:8080', sslEnabled: false);
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/homepage':
            return MaterialPageRoute(builder: (context) => const Homepage());
          case '/search_restaurant':
            return MaterialPageRoute(
                builder: (context) => const SearchRestaurant());
          case '/location':
            final List<Restaurant> restaurants = settings.arguments as List<Restaurant>;
            return MaterialPageRoute(
              builder: (context) => LocationScreen(restaurants),
            );

          case '/restaurant_menu':
            final Restaurant restaurant = settings.arguments as Restaurant;
            return MaterialPageRoute(
                builder: (context) => RestaurantMenu(restaurant));
          case '/product_selected':
            final Product product = settings.arguments as Product;
            return MaterialPageRoute(
                builder: (context) => ProductSelected(product));
          case '/bag':
            return MaterialPageRoute(builder: (context) => const BagScreen());
          case '/payment':
            return MaterialPageRoute(builder: (context) => const Payment());
          case '/order':
            return MaterialPageRoute(builder: (context) => const OrderScreen());
        }
      },
      // routes: {
      // '/homepage': (context) => const Homepage(),
      // '/search_restaurant': (context) => const SearchRestaurant(),
      // '/location': (context) => const LocationScreen(),
      // '/restaurant_menu': (context) => RestaurantMenu(Restaurant()),
      // '/product_selected': (context) => const ProductSelected(),
      // '/bag': (context) => const BagScreen(),
      // '/payment': (context) => const Payment(),
      // '/order': (context) => const OrderScreen(),
      // },
    );
  }
}
