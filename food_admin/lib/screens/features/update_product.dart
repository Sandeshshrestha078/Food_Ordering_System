import 'package:flutter/material.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({super.key});
  static const String id = "update";
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'UPDATE PRODUCT',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
