import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';

class ShoppingBag extends ChangeNotifier {
  late String restaurantPhoto;
  late String restaurantName;

  late String restaurantId;

  final List<Product> products = []; // coca, coca, calabreso
  final List<Product> bag = []; // coca, calabreso
  double totalPrice = 0;

  void updateBag() {
    bag.clear(); // Limpa a lista bag antes de atualizar

  for (var prod in products) {
    if (!bag.contains(prod)) {
      bag.add(prod);
    }
  }

    print('--------------------------------------------');

    print('%%% Tamanho da Sacola - ${bag.length} %%%');

    int itemIndx = 0;
    for (var item in bag) {
      itemIndx++;
      print('-> Item $itemIndx da Sacola - ${item.name}');
    }

    print('%%% Tamanho de Produtos - ${products.length} %%%');

    int prodIndx = 0;
    for (var prod in products) {
      prodIndx++;
      print('-> Item $prodIndx de Produtos - ${prod.name}');
    }

    print('--------------------------------------------');
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
