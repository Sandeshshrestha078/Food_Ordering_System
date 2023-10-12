import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  static const String id = "dashboard";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Dashboard',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }
}
