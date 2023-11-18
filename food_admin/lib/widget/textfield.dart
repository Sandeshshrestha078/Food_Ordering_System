// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  // final TextEditingController controller;
  final String label;
  final bool tohide;
  final String msg;
  final int? maxLines;
  final TextEditingController controller;
  const CommonTextFormField({
    Key? key,
    required this.label,
    required this.tohide,
    required this.msg,
    this.maxLines,
    required this.controller,
  }) : super(key: key);

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool isfocous = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
      controller: widget.controller,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.msg;
        }
        return null;
      },
    );
  }
}
