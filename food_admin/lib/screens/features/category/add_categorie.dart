import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:food_admin/constant/values.dart';
import 'package:food_admin/widget/textfield.dart';

class AddCategorie extends StatelessWidget {
  const AddCategorie({super.key});
  static const String id = "category";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: categoryPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Add Category",
            style: headerStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: 500,
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
                        'Category',
                        style: titleStyle,
                      ),
                    ),
                  ),

                  //form field

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 15.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category Title',
                            style: titleStyle2,
                          ),
                          const SizedBox(height: 10),
                          const CommonTextFormField(
                              label: 'Title', tohide: false),
                          const SizedBox(height: 25),

                          //choose image field
                          Row(
                            children: [
                              const Text(
                                'Category Image',
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
                                      color: Color.fromRGBO(238, 238, 238, 1)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.photo,
                                        size: 50,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            'Choose an image',
                                            style: chooseimg,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 100),
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {},
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
    );
  }
}
