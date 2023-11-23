import 'dart:ffi';

import 'package:pick_pega/models/shopping_bag.dart';

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

  // Adicione este método para converter a instância de OrderModel em um mapa
  Map<String, dynamic> toJson() {
   
    return {
      'status': status,
      'date': date,
      'time': time,
      'name': name,
      'payment': payment,
      'products': products,
      'necessaryTime': necessaryTime,
      'price': price,
    };
  }

  // Adicione este método para criar uma instância de OrderModel a partir de um mapa
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      status: json['status'],
      date: json['date'],
      time: json['time'],
      name: json['name'],
      payment: json['payment'],
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      necessaryTime: json['necessaryTime'],
      price: json['price'],
    );
  }
}


