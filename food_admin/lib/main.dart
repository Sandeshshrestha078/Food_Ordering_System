import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_admin/screens/features/add_product.dart';
import 'package:food_admin/screens/features/category/add_categorie.dart';
import 'package:food_admin/screens/features/category/view_category.dart';
// import 'package:food_admin/screens/features/category/view_category.dart';
import 'package:food_admin/screens/features/dashboard.dart';
import 'package:food_admin/screens/features/delete_product.dart';
import 'package:food_admin/screens/features/update_product.dart';
import 'package:food_admin/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    storageBucket: 'gs://food-ordering-system-cb3b7.appspot.com',
    apiKey: "AIzaSyDFLjtxXPZypWWJt9KJ8ST8ZFxkLfUw9GI",
    projectId: "food-ordering-system-cb3b7",
    messagingSenderId: "453053012589",
    appId: "1:453053012589:web:dad07bcbfd3e8f8585fd64",
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      routes: {
        DashboardScreen.id: (context) => const DashboardScreen(),
        AddProductScreen.id: (context) => const AddProductScreen(),
        UpdateProductScreen.id: (context) => const UpdateProductScreen(),
        DeleteProductScreen.id: (context) => const DashboardScreen(),
        AddCategorie.id: (context) => const AddCategorie(),
        ViewCategory.id: (context) => const ViewCategory(),
      },
    );
  }
}
