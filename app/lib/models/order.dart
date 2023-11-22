import 'dart:ffi';

import 'product.dart';

class OrderModel {
  String? status = 'Em espera';
  String date;
  String time;
  String name;
  String payment;
  List<Product> products;
  int necessaryTime;
  double price;

  OrderModel({
    this.status,
    required this.date,
    required this.time,
    required this.name,
    required this.payment,
    required this.products,
    required this.necessaryTime,
    required this.price,
  });
}
