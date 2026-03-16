import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String id;
  final String name;
  final String address;
  final String merchantId;
  final String? imageUrl;

  StoreModel({
    required this.id,
    required this.name,
    required this.address,
    required this.merchantId,
    this.imageUrl,
  });

  factory StoreModel.fromDocument(DocumentSnapshot doc) {
    return StoreModel(
      id: doc.id,
      name: doc['name'] ?? '',
      address: doc['address'] ?? '',
      merchantId: doc['merchantId'] ?? '',
      imageUrl: doc['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'merchantId': merchantId,
      'imageUrl': imageUrl,
    };
  }
}
