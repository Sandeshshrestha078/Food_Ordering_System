import 'package:flutter/material.dart';
import 'package:food_admin/screens/features/add_product.dart';
import 'package:food_admin/screens/features/category/add_categorie.dart';
import 'package:food_admin/screens/features/category/view_category.dart';
import 'package:food_admin/screens/features/dashboard.dart';
import 'package:food_admin/screens/features/delete_product.dart';
import 'package:food_admin/screens/features/update_product.dart';
import 'package:food_admin/screens/home_screen.dart';

void main() {
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
