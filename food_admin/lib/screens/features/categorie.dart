import 'package:flutter/material.dart';

class CategorieScreen extends StatelessWidget {
  const CategorieScreen({super.key});
  static const String id = "categorie";
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'CATEGORIES',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
