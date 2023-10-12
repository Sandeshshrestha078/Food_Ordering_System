import 'package:flutter/material.dart';

class DeleteProductScreen extends StatelessWidget {
  const DeleteProductScreen({super.key});
  static const String id = "delete";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'DELETE PRODUCT',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
