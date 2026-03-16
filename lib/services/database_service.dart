import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/store_model.dart';
import '../models/product_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- GESTION DES MAGASINS ---

  // Récupérer les magasins d'un commerçant
  Stream<List<StoreModel>> getMerchantStores(String merchantId) {
    return _db
        .collection('stores')
        .where('merchantId', isEqualTo: merchantId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => StoreModel.fromDocument(doc)).toList());
  }

  // Ajouter un magasin
  Future<void> addStore(StoreModel store) async {
    await _db.collection('stores').add(store.toMap());
  }

  // --- GESTION DES PRODUITS ---

  // Récupérer les produits d'un magasin spécifique
  Stream<List<ProductModel>> getStoreProducts(String storeId) {
    return _db
        .collection('products')
        .where('storeId', isEqualTo: storeId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ProductModel.fromDocument(doc)).toList());
  }

  // Ajouter un produit à un magasin
  Future<void> addProduct(ProductModel product) async {
    await _db.collection('products').add(product.toMap());
  }

  // Mettre à jour le prix d'un produit et l'ajouter à l'historique
  Future<void> updateProductPrice(String productId, double newPrice) async {
    DocumentReference ref = _db.collection('products').doc(productId);
    
    await _db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(ref);
      if (!snapshot.exists) return;

      List history = List.from(snapshot['priceHistory'] ?? []);
      history.add({
        'price': newPrice,
        'date': Timestamp.now(),
      });

      transaction.update(ref, {
        'currentPrice': newPrice,
        'priceHistory': history,
      });
    });
  }
}
