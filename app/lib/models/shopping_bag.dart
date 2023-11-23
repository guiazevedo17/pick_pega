import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';

class ShoppingBag extends ChangeNotifier {
  late String restaurantPhoto;
  late String restaurantName;

  late String restaurantId;

  final List<Product> products = []; // coca, coca, calabreso
  final List<Product> bag = []; // coca, calabreso
  double totalPrice = 0;

  // ShoppingBag(
  //   {

  //   }
  // );

  // ShoppingBag(
  //   {
  //     required this.bag
  //   }
  // );
  // Adicione este método para converter a instância de OrderModel em um mapa
  // Map<String, dynamic> toJson() {
  //   return {

  //     'bag': bag.map((bag) => bag.toJson()).toList(),
  //   };
  // }

  // // Adicione este método para criar uma instância de OrderModel a partir de um mapa
  // factory ShoppingBag.fromJson(Map<String, dynamic> json) {
  //   return ShoppingBag(
  //     bag: (json['bag'] as List<dynamic>)
  //         .map((bagJson) => Product.fromJson(bagJson))
  //         .toList(),
  //   );
  // }

  void updateBag() {
    for (var prod in products) {
      if (!bag.contains(prod)) {
        bag.add(prod);
      }
    }
  }

  void addToBag(Product product) {
    products.add(product);

    updateBag();

    updateTotalPrice();
  }

  void reduceProduct(Product product) {
    products.remove(product);

    if (products.contains(product)) {
      updateTotalPrice();
    }
  }

  void deleteFromBag(Product product) {
    bag.remove(product);

    updateTotalPrice();
  }

  void updateTotalPrice() {
    totalPrice = 0;

    for (var prod in products) {
      totalPrice += prod.price;
    }

    notifyListeners();
  }

  int updateTotalTime() {
    int totalTime = 0;

    for (var item in bag) {
      if (item.time > totalTime) {
        totalTime = item.time;
      }
    }

    return totalTime;
  }

  void clearBag() {
    products.clear();
    bag.clear();

    updateTotalPrice();
  }
}
