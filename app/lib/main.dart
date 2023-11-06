import 'package:cloud_firestore/cloud_firestore.dart';
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
  FirebaseFirestore.instance.settings = Settings(host: 'localhost:8080', sslEnabled: false);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(
      // ChangeNotifierProvider<RestaurantsRepository>(
      //   create: (context) => RestaurantsRepository(),
      //   child: const MyApp(),
      // ),
      MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  // Future<void> getRestaurantData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   CollectionReference restaurantes = firestore.collection('Restaurant');
  //
  //   QuerySnapshot querySnapshot = await restaurantes.get();
  //   for (QueryDocumentSnapshot document in querySnapshot.docs) {
  //     Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //
  //     // Agora você pode acessar os campos de dados do restaurante, por exemplo:
  //     email = data['email'];
  //
  //     // E assim por diante...
  //
  //     // Faça o que quiser com os dados do restaurante aqui.
  //     print('Nome: $email');
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pick Pega',
      debugShowCheckedModeBanner: false,
      initialRoute: '/search_restaurant',
      routes: {
        '/homepage': (context) => const Homepage(),
        '/search_restaurant': (context) =>  SearchRestaurant(),
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
