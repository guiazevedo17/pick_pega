class Product {
  String restaurantId;
  String category;
  String itemId;
  String name;
  String description;
  double price;
  int time;
  String picture;

  Product({
    required this.restaurantId,
    required this.category,
    required this.itemId,
    required this.name,
    required this.description,
    required this.price,
    required this.time,
    required this.picture,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        restaurantId: json['restaurantId'],
        category: json['category'],
        itemId: json['itemId'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        time: json['time'],
        picture: json['picture']);
  }
}
