import 'package:flutter/material.dart';
import 'package:pick_pega/models/product.dart';

class ShoppingBag extends ChangeNotifier {
  final List<Product> products = [];
  final String status = 'Em espera';
  
}
