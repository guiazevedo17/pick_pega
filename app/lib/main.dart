import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pick_pega/models/restaurant.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:pick_pega/screens/bag.dart';
import 'package:pick_pega/screens/homepage.dart';
import 'package:pick_pega/screens/order_screen.dart';
import 'package:pick_pega/screens/restaurant_menu.dart';
import 'package:pick_pega/screens/search_restaurant.dart';
import 'models/order.dart';
import 'models/product.dart';
import 'models/shopping_bag.dart';
import 'screens/location.dart';
import 'screens/card_payment.dart';
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
    ChangeNotifierProvider(
      create: (context) => ShoppingBag(),
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
      initialRoute: '/homepage',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/homepage':
            return MaterialPageRoute(builder: (context) => const Homepage());
          case '/search_restaurant':
            return MaterialPageRoute(
                builder: (context) => const SearchRestaurant());
          case '/location':
            return MaterialPageRoute(
                builder: (context) => const LocationScreen());
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
          case '/card_payment':
            final String payment = settings.arguments as String;
            return MaterialPageRoute(
                builder: (context) => CardPayment(payment));
          case '/order':
            final OrderModel order = settings.arguments as OrderModel;
            return MaterialPageRoute(builder: (context) => OrderScreen(order));
        }
      },
    );
  }
}
