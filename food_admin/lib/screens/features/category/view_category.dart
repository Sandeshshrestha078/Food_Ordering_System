import 'package:flutter/material.dart';
import 'package:food_admin/constant/values.dart';

class ViewCategory extends StatefulWidget {
  const ViewCategory({
    super.key,
  });
  static const String id = "view category";

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: categoryPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'View Category',
            style: headerStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(children: [
                Container(
                  width: double.infinity,
                  decoration: categorieStyle,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                    child: Text(
                      'Category Detail',
                      style: titleStyle,
                    ),
                  ),
                ),

                // tabel
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 15.0),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(
                            color: const Color.fromRGBO(189, 189, 189, 1)),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: const [
                          TableRow(
                            children: [],
                          ),

                          // data comming from firebase
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
