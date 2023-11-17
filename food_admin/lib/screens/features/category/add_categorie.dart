import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryTitleController = TextEditingController();
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  bool isImageSelected = false;
  String imageName = '';

// function to pick image from gallery
  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          imageName = image.name;
          isImageSelected = true;
          _pickedImage = selected;
        });
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
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          imageName = image.name;
          isImageSelected = true;
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        log('No image has been picked');
      }
    } else {
      log('something went wrong');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _saveImageToFirebaseStorage() async {
    if (webImage.isNotEmpty) {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('category_images/$imageName');

      try {
        UploadTask uploadTask = storageReference.putData(webImage);
        TaskSnapshot storageTaskSnapshot = await uploadTask;

        if (storageTaskSnapshot.state == TaskState.success) {
          // Image has been successfully uploaded to Firebase Storage.
          String downloadUrl = await storageReference.getDownloadURL();
          log('Image uploaded to Firebase Storage. Download URL: $downloadUrl');
          // Now, save the category title along with the download URL to Firebase.
          await saveCategoryToFirebase(downloadUrl);
          // Show a Snackbar with a success message.
          _showSnackBar('Image uploaded successfully');
          // Reset the text field.
          categoryTitleController.clear();
          // Clear the picked image.
          setState(() {
            _pickedImage = null;
          });
        } else {
          log('Failed to upload image to Firebase Storage.');
        }
      } catch (e) {
        log('Error uploading image to Firebase Storage: $e');

        // Show a Snackbar with an error message.
        _showSnackBar('Failed to upload image');
      }
    } else {
      log('No image to upload.');

      // Show a Snackbar with a message.
      _showSnackBar('No image to upload');
    }
  }

// Function to save the category details to Firebase.
  Future<void> saveCategoryToFirebase(String imageUrl) async {
    try {
      // Get the category title from the text field.
      String categoryTitle = categoryTitleController.text.trim();

      // Save the category details to Firestore.
      await FirebaseFirestore.instance.collection('categories').add({
        'title': categoryTitle,
        'image_url': imageUrl,
      });

      // For demonstration purposes, log the category details.
      log('Category Title: $categoryTitle');
      log('Image URL: $imageUrl');
    } catch (e) {
      log('Error saving category to Firestore: $e');
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Category Title',
                              style: titleStyle2,
                            ),
                            const SizedBox(height: 10),
                            CommonTextFormField(
                              controller: categoryTitleController,
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
                                            child: _pickedImage == null
                                                ? const Center(
                                                    child: Text('No image'),
                                                  )
                                                : kIsWeb
                                                    ? Image.memory(
                                                        webImage,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.file(
                                                        _pickedImage!,
                                                        fit: BoxFit.fill,
                                                      ),
                                          ),
                                          TextButton(
                                              onPressed: ((() => _pickImage())),
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
                        // Call the function to save the image to Firebase Storage when the button is pressed.
                        if (_formKey.currentState!.validate()) {
                          if (isImageSelected) {
                            _saveImageToFirebaseStorage();
                          } else {
                            // Display an error message in the UI or show a snackbar.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Please select an image before saving.'),
                              ),
                            );
                          }
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
