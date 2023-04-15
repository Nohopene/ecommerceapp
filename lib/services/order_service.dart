import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  CollectionReference orders = FirebaseFirestore.instance.collection('order');

  Future<DocumentReference> saveOrder(Map<String, dynamic> data) {
    var result = orders.add(data);
    return result;
  }
}
