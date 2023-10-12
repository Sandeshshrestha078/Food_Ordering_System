import 'package:flutter/material.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});
  static const String id = "add";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'ADD PRODUCT',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
