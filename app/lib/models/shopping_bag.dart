import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';

class ShoppingBag extends ChangeNotifier {
  late String restaurantPhoto;
  late String restaurantName;

  final List<Product> products = [Product(active: false, restaurantId: 'jYspAycmUBdgMCHb3Bez', category: 'Bebidas', itemId: '4NeyEBqNke5P98dEc7fz', name:  'Coca Zero Açucar', description: 'coca zero açucar geladinha', price: 6.99, time: 0, picture: 'https://firebasestorage.googleapis.com/v0/b/pick-pega.appspot.com/o/FotosItems%2Fdownload%20(1).jpeg-3087fd7d-e662-44da-aed5-acace9dfb6d7?alt=media&token=f02fcde2-cb83-4834-9b98-18853c91003a')]; // coca, coca, calabreso
  final List<Product> bag = []; // coca, calabreso
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
