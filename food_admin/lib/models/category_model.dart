import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
// fetch category tilte
  Future<List<String>> getCategories() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    List<String> categories =
        querySnapshot.docs.map((doc) => doc['title'] as String).toList();

    return categories;
  }
}
