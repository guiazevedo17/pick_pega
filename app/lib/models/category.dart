import 'package:pick_pega/models/product.dart';

class Category {
  String name;
  List<Product> products;

  Category({
    required this.name,
    required this.products
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      products: json['products']
    );
  }
}
