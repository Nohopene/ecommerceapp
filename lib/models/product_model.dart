// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.brands,
    required this.quantity,
    required this.regularPrice,
    required this.percentOff,
    required this.descriptions,
    required this.rating,
    required this.isAvailable,
    required this.createdAt,
    required this.isSale,
    required this.isPopular,
    required this.guarantee,
  });

  final String name;

  final List imageUrl;

  final String category;

  final String? brands;

  final int quantity;

  final int regularPrice;

  final int? percentOff;

  final String? descriptions;

  final int? rating;

  final bool isAvailable;

  final Timestamp? createdAt;

  final bool isSale;

  final bool isPopular;

  final int guarantee;

  int get price => (regularPrice * (100 - percentOff!) / 100).ceil();

  Product.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          imageUrl: json['imageUrl']! as List,
          category: json['category']! as String,
          brands: json['brands'] == null ? null : json['brands']! as String,
          quantity: json['quantity']! as int,
          regularPrice: json['regularPrice']! as int,
          percentOff:
              json['percentOff'] == null ? null : json['percentOff']! as int,
          descriptions: json['descriptions'] == null
              ? null
              : json['descriptions']! as String,
          rating: json['rating'] == null ? null : json['rating']! as int,
          isAvailable: json['isAvailable']! as bool,
          createdAt: json['createdAt'] == null
              ? null
              : json['createdAt']! as Timestamp,
          isSale: json['isSale']! as bool,
          isPopular: json['isPopular']! as bool,
          guarantee: json['guarantee']! as int,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'category': category,
      'brands': brands,
      'quantity': quantity,
      'regularPrice': regularPrice,
      'percentOff': percentOff,
      'descriptions': descriptions,
      'rating': rating,
      'isAvailable': isAvailable,
      'createdAt': createdAt,
      'isSale': isSale,
      'isPopurlar': isPopular,
      'guarantee': guarantee,
    };
  }
}

productQuery({category}) {
  return FirebaseFirestore.instance
      .collection('products')
      .where('isAvailable', isEqualTo: true)
      .where('category', isEqualTo: category)
      .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson());
}

productQuery1() {
  return FirebaseFirestore.instance
      .collection('products')
      .where('isAvailable', isEqualTo: true)
      .where('isPopular', isEqualTo: true)
      .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson());
}

productQuery2() {
  return FirebaseFirestore.instance
      .collection('products')
      .where('isAvailable', isEqualTo: true)
      .where('isSale', isEqualTo: true)
      .withConverter<Product>(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson());
}
