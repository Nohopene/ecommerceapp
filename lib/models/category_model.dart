import 'package:ecommerceapp/services/firebase_service.dart';

class Category {
  Category({required this.name});

  Category.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
        );

  final String name;

  Map<String, Object?> toJson() {
    return {
      'name': name,
    };
  }
}

FirebaseService _service = FirebaseService();
final categoryQuery = _service.categories
    .where('active', isEqualTo: true)
    .withConverter<Category>(
      fromFirestore: (snapshot, _) => Category.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
