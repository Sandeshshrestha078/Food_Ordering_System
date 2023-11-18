import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:food_admin/constant/values.dart';

import '../../widget/textfield.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  static const String id = "add";

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productDetailController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: categoryPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Add product",
              style: headerStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: categorieStyle,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18.0),
                        child: Text(
                          'Product',
                          style: titleStyle,
                        ),
                      ),
                    ),

                    //form field

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonTextFormField(
                                controller: productTitleController,
                                label: 'Product Name',
                                tohide: false,
                                msg: 'Product Name Required',
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                maxLines: 4,
                                controller: productDetailController,
                                label: 'Product Detail',
                                tohide: false,
                                msg: 'Product Detail Required',
                              ),
                              const SizedBox(height: 25),
                              CommonTextFormField(
                                controller: productPriceController,
                                label: 'Price',
                                tohide: false,
                                msg: 'Product Price Required',
                              ),
                              const SizedBox(height: 25),

                              //choose image field
                              Row(
                                children: [
                                  const Text(
                                    'Product Image',
                                    style: titleStyle2,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  DottedBorder(
                                    dashPattern: const [8, 4, 8, 4],
                                    borderType: BorderType.RRect,
                                    radius: const Radius.circular(12),
                                    padding: const EdgeInsets.all(6),
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(238, 238, 238, 1),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {},
                                                child: const Text(
                                                  'Choose an image',
                                                  style: chooseimg,
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      margin: const EdgeInsets.only(left: 100),
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log('ready to save');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Please select an image before saving.'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Save',
                          style: titleStyle2,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
