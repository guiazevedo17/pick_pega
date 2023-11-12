import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';

class ShoppingBag extends ChangeNotifier {
  final List<Product> products = [];
  final List<Product> bag = [];
  double totalPrice = 0;

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

  void deleteFromBag(Product product) {
    products.remove(product);

    updateTotalPrice();
  }

  void updateTotalPrice() {
    totalPrice = 0;

    for (var prod in products) {
      totalPrice += prod.price;
    }

    notifyListeners();
  }
}
