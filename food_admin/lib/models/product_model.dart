import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? category;
  String? id;
  String? productName;
  String? detail;
  String? price;
  List<String>? imageUrls;
  bool? isPopular;
  bool? isFavourite;

  Product({
    this.category,
    this.id,
    this.productName,
    this.detail,
    this.price,
    this.imageUrls,
    this.isPopular,
    this.isFavourite,
  });

  static Future<void> addProducts(Product products) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": products.category,
      "id": products.id,
      "productName": products.productName,
      "detail": products.detail,
      "price": products.price,
      "imageUrls": products.imageUrls,
      "isPopular": products.isPopular,
      "isFavourite": products.isFavourite,
    };
    await db.add(data);
  }

  static Future<void> updateProducts(String id, Product updateProducts) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    Map<String, dynamic> data = {
      "category": updateProducts.category,
      "productName": updateProducts.productName,
      "id": updateProducts.id,
      "detail": updateProducts.detail,
      "price": updateProducts.price,
      "imageUrls": updateProducts.imageUrls,
      "isPopular": updateProducts.isPopular,
      "isFavourite": updateProducts.isFavourite,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    CollectionReference db = FirebaseFirestore.instance.collection("products");

    await db.doc(id).delete();
  }
}
