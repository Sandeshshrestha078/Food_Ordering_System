import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  // final TextEditingController controller;
  final String label;
  final bool tohide;
  const CommonTextFormField({
    Key? key,
    // required this.controller,
    required this.label,
    required this.tohide,
  }) : super(key: key);

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool isfocous = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: widget.controller,
      obscureText: widget.tohide,
      decoration: InputDecoration(
        hintText: widget.label,
        hintStyle: const TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.blueGrey)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
