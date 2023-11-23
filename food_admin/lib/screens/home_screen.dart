import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:food_admin/screens/features/add_product.dart';
import 'package:food_admin/screens/features/category/add_categorie.dart';
// import 'package:food_admin/screens/features/category/view_category.dart';
import 'package:food_admin/screens/features/dashboard.dart';
import 'package:food_admin/screens/features/delete_product.dart';
import 'package:food_admin/screens/features/update_product.dart';

import 'features/category/view_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String id = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget selectedScreen = const UpdateProductScreen();
  chooseScreens(item) {
    switch (item.route) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = const DashboardScreen();
        });
        break;
      case AddCategorie.id:
        setState(() {
          selectedScreen = const AddCategorie();
        });
        break;
      // case ViewCategory.id:
      //   setState(() {
      //     selectedScreen = const ViewCategory();
      //   });
      // break;
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

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: const Color.fromARGB(255, 232, 234, 235),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 57, 74, 83),
          centerTitle: true,
          title: const Text(
            'Admin Panel',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
        sideBar: SideBar(
          borderColor: const Color.fromRGBO(47, 56, 61, 1),
          backgroundColor: const Color.fromRGBO(47, 56, 61, 1),
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          items: const [
            AdminMenuItem(
              title: 'DASHBOARD',
              route: DashboardScreen.id,
              icon: Icons.dashboard,
            ),
            AdminMenuItem(
              title: 'CATEGORY',
              icon: Icons.category,
              children: [
                AdminMenuItem(
                  title: 'ADD CATEGORY',
                  route: AddCategorie.id,
                ),
                AdminMenuItem(
                  title: 'VIEW CATEGORY',
                  route: ViewCategory.id,
                ),
              ],
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
          ],
          selectedRoute: HomeScreen.id,
          onSelected: (item) {
            chooseScreens(item);
          },
        ),
        body: selectedScreen);
  }
}
