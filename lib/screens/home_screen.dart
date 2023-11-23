import 'package:flutter/material.dart';
import 'package:food_users/widget/heading_widget.dart';

class HomeScreeen extends StatelessWidget {
  const HomeScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('food ')),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            child: Column(
              children: [
                //heading
                HeadingWidget(
                    headingTitle: 'Categories',
                    buttonText: 'See More',
                    onTap: () {}),
                HeadingWidget(
                    headingTitle: 'Popular',
                    buttonText: 'See More',
                    onTap: () {}),
                HeadingWidget(
                    headingTitle: 'All Products',
                    buttonText: 'See More',
                    onTap: () {}),
              ],
            ),
          ),
        ));
  }
}
