class Cart {
  Cart({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  final String? productId;

  final String name;

  final List imageUrl;

  final int quantity;

  final int price;

  final int totalPrice;

  Cart.fromJson(Map<String, Object?> json)
      : this(
          productId: json['productId']! as String,
          name: json['name']! as String,
          imageUrl: json['imageUrl']! as List,
          quantity: json['quantity']! as int,
          price: json['price']! as int,
          totalPrice: json['totalPrice']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'productId': productId,
      'name': name,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
    };
  }
}
