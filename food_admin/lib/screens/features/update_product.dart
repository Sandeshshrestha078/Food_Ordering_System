import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_admin/models/product_model.dart';

import '../../constant/values.dart';

// Now, you can retrieve data using queries (e.g., myCollection.get()).

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});
  static const String id = "update";

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: categoryPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Update product",
              style: headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: myCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DataTable(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  Colors.black), // Optional: Set border color
                        ),
                        columns: const <DataColumn>[
                          DataColumn(
                              label: Text(
                            'Product Name',
                            style: updatestyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Price',
                            style: updatestyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Category',
                            style: updatestyle,
                          )),
                          DataColumn(
                              label: Text(
                            'Actions',
                            style: updatestyle,
                          )),
                        ],
                        rows: _buildRows(snapshot.data?.docs),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(List<QueryDocumentSnapshot>? documents) {
    return documents?.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return DataRow(
            cells: <DataCell>[
              DataCell(
                  Text(data['productName'].toString(), style: updateRowStyle)),
              DataCell(Text(
                data['price'].toString(),
                style: updateRowStyle,
              )),
              DataCell(Text(
                data['category'].toString(),
                style: updateRowStyle,
              )),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        print('Update button pressed');
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _deleteProduct(document.id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList() ??
        [];
  }

  Future<void> _deleteProduct(String productId) async {
    try {
      await myCollection.doc(productId).delete();
    } catch (error) {
      print("Error deleting product: $error");
    }
  }
}
