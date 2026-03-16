import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final double currentPrice;
  final String category;
  final String storeId;
  final List<Map<String, dynamic>> priceHistory;
  final String? imageUrl;

  ProductModel({
    required this.id,
    required this.name,
    required this.currentPrice,
    required this.category,
    required this.storeId,
    required this.priceHistory,
    this.imageUrl,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    return ProductModel(
      id: doc.id,
      name: doc['name'] ?? '',
      currentPrice: (doc['currentPrice'] ?? 0).toDouble(),
      category: doc['category'] ?? 'Autre',
      storeId: doc['storeId'] ?? '',
      priceHistory: List<Map<String, dynamic>>.from(doc['priceHistory'] ?? []),
      imageUrl: doc['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'currentPrice': currentPrice,
      'category': category,
      'storeId': storeId,
      'priceHistory': priceHistory,
      'imageUrl': imageUrl,
    };
  }
}
