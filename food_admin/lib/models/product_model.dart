import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? category;
  String? id;
  String? productName;
  String? detail;
  int? price;
  List<String>? imageUrls;
  bool? isPopular;
  bool? isFavourite;

  Products({
    required this.category,
    required this.id,
    required this.productName,
    required this.detail,
    required this.price,
    required this.imageUrls,
    required this.isPopular,
    required this.isFavourite,
  });

  Future<void> addProducts(Products products) async {
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
    await db.doc(products.productName).set(data);
  }

  static Future<void> updateProducts(String id, Products updateProducts) async {
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
