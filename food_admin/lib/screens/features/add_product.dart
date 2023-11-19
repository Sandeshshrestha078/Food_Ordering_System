import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_admin/constant/values.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/category_model.dart';
import '../../models/product_model.dart';
import '../../widget/textfield.dart';
import 'package:uuid/uuid.dart';

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
  CategoryService categoryService = CategoryService();

  bool isPopular = false;
  bool isFavourite = false;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  bool isImageSelected = false;
  String imageName = '';
  List<String> imageUrl = [];
  var uuid = const Uuid();
  String? selectedCategory;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    // Call getCategories to populate the categories list
    categoryService.getCategories().then((result) {
      setState(() {
        categories = result;
        print('Categories: $categories');
        print('Selected Category: $selectedCategory');
      });
    });
  }

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
          FirebaseStorage.instance.ref().child('product_image/$imageName');

      try {
        UploadTask uploadTask = storageReference.putData(webImage);
        TaskSnapshot storageTaskSnapshot = await uploadTask;

        if (storageTaskSnapshot.state == TaskState.success) {
          // Image has been successfully uploaded to Firebase Storage.
          String downloadUrl = await storageReference.getDownloadURL();
          log('Image uploaded to Firebase Storage. Download URL: $downloadUrl');
          // Show a Snackbar with a success message.

          // Clear the picked image.
          setState(() {
            imageUrl.add(downloadUrl);
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
                              DropdownButtonFormField(
                                  hint: const Text(
                                    'Choose Category',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.blueGrey)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Category must be selected";
                                    }
                                    return null;
                                  },
                                  value: selectedCategory,
                                  items: categories
                                      .map((e) => DropdownMenuItem<String>(
                                          value: e, child: Text(e)))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCategory = value.toString();
                                    });
                                  }),
                              const SizedBox(height: 25),

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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SwitchListTile(
                                  title: const Text(
                                    "Is this Product Popular?",
                                    style: titleStyle2,
                                  ),
                                  value: isPopular,
                                  onChanged: (v) {
                                    setState(() {
                                      isPopular = !isPopular;
                                    });
                                  }),
                            ]),
                      ),
                    ),

                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 80, bottom: 40),
                      child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (isImageSelected) {
                              save();
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
      ),
    );
  }

  save() async {
    await _saveImageToFirebaseStorage();
    Products products = Products(
      category: selectedCategory,
      id: uuid.v4(),
      productName: productTitleController.text,
      detail: productDetailController.text,
      price: int.parse(productPriceController.text),
      imageUrls: imageUrl,
      isPopular: isPopular,
      isFavourite: isFavourite,
    );

    await products.addProducts(products).whenComplete(() {
      setState(() {
        _showSnackBar('ADDED SUCCESSFULLY');
        productTitleController.clear();
        productDetailController.clear();
        productPriceController.clear();
        isPopular = false;
        _pickedImage = null;
        isImageSelected = false;
        imageName = '';
        imageUrl.clear();
        selectedCategory = null;
      });
    });
  }
}
