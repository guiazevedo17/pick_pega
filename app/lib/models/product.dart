class Product {
  bool active;
  String restaurantId;
  String category;
  String itemId;
  String name;
  String description;
  double price;
  int time;
  String picture;
  int? qntd;

  Product(
      {required this.active,
      required this.restaurantId,
      required this.category,
      required this.itemId,
      required this.name,
      required this.description,
      required this.price,
      required this.time,
      required this.picture,
      this.qntd});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        active: json['active'],
        restaurantId: json['restaurantId'],
        category: json['category'],
        itemId: json['itemId'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        time: json['time'],
        picture: json['picture'],
        qntd: json['qntd']);
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'restaurantId': restaurantId,
      'category': category,
      'itemId': itemId,
      'name': name,
      'description': description,
      'price': price,
      'time': time,
      'picture': picture,
      'qntd': qntd
    };
  }
}
