import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';

class ShoppingBag extends ChangeNotifier {
  final List<Product> products = []; // coca, coca, calabreso
  final List<Product> bag = []; // coca, calabreso
  late double totalPrice;

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
}
