import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:food_admin/screens/features/add_product.dart';
import 'package:food_admin/screens/features/categorie.dart';
import 'package:food_admin/screens/features/dashboard.dart';
import 'package:food_admin/screens/features/delete_product.dart';
import 'package:food_admin/screens/features/update_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget selectedScreen = const DashboardScreen();
  chooseScreens(item) {
    switch (item.route) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = const DashboardScreen();
        });
        break;
      case CategorieScreen.id:
        setState(() {
          selectedScreen = const CategorieScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = const AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = const DeleteProductScreen();
        });
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Admin Panel',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        sideBar: SideBar(
          textStyle: const TextStyle(
              color: Color.fromARGB(146, 0, 0, 0), fontSize: 16),
          items: const [
            AdminMenuItem(
              title: 'DASHBOARD',
              route: DashboardScreen.id,
              icon: Icons.dashboard,
            ),
            AdminMenuItem(
              title: 'CATEGORIES',
              route: CategorieScreen.id,
              icon: Icons.category,
            ),
            AdminMenuItem(
              title: 'ADD PRODUCT',
              route: AddProductScreen.id,
              icon: Icons.add,
            ),
            AdminMenuItem(
              title: 'UPDATE PRODUCT',
              route: UpdateProductScreen.id,
              icon: Icons.update,
            ),
            AdminMenuItem(
              title: 'DELETE PRODUCT',
              route: DeleteProductScreen.id,
              icon: Icons.delete,
            ),
          ],
          selectedRoute: HomeScreen.id,
          onSelected: (item) {
            chooseScreens(item);
          },
        ),
        body: selectedScreen);
  }
}
