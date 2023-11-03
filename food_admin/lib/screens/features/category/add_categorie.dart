import 'dart:developer';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:food_admin/constant/values.dart';
import 'package:food_admin/widget/textfield.dart';
import 'package:image_picker/image_picker.dart';

class AddCategorie extends StatefulWidget {
  const AddCategorie({super.key});
  static const String id = "category";

  @override
  State<AddCategorie> createState() => _AddCategorieState();
}

class _AddCategorieState extends State<AddCategorie> {
  File? categoryPic;
  String imageName = '';
  Uint8List webImage = Uint8List(8);
  bool isImageSelected = false;
  Future imagePicker() async {
    final BuildContext context = this.context;
    if (!kIsWeb) {
      XFile? selectedimg =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (selectedimg != null) {
        var convertedFile = File(selectedimg.path);

        setState(() {
          imageName = selectedimg.name;
          categoryPic = convertedFile;
        });
        log('Image selected: $imageName');
      } else {
        // Handle case where no image is selected.
        isImageSelected = false;
        // Display an error message in the UI or show a snackbar.
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image not selected'),
          ),
        );
      }
    } else if (kIsWeb) {
      XFile? selectedimg =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (selectedimg != null) {
        var f = await selectedimg.readAsBytes();
        // Get the name of the selected image
        setState(() {
          imageName = selectedimg.name;
          webImage = f;
          categoryPic = File('a');
        });
        log('Image selected: $imageName');
      } else {
        return ('image not selected');
      }
    } else {
      log('Something went wrong');
    }
  }

  Future<void> uploadImageToFirebaseStorage(
      Uint8List imageBytes, String imageName) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference storageReference = storage.ref().child("images/$imageName");

    try {
      await storageReference.putData(imageBytes);
      log('Image uploaded to Firebase Storage');
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

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
                            label: 'Title',
                            tohide: false,
                            msg: 'Product Name Required',
                          ),
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
                                    color: Color.fromRGBO(238, 238, 238, 1),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: categoryPic == null
                                              ? const Center(
                                                  child: Text('no image'),
                                                )
                                              : kIsWeb
                                                  ? Image.memory(webImage,
                                                      fit: BoxFit.fill)
                                                  : Image.file(categoryPic!,
                                                      fit: BoxFit.fill),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              imagePicker();
                                            },
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
                  const SizedBox(
                    height: 20,
                  ),

                  Container(
                    margin: const EdgeInsets.only(left: 100),
                    child: ElevatedButton(
                      style: buttonStyle,
                      onPressed: () {
                        if (isImageSelected) {
                          uploadImageToFirebaseStorage(webImage, imageName);
                          setState(() {
                            webImage = Uint8List(8); // Reset the webImage.
                          });
                        } else {
                          // Display an error message in the UI or show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please select an image before saving.'),
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
    );
  }
}
