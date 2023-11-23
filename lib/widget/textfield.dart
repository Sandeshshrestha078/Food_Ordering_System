import 'package:flutter/material.dart';

class CommonTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final bool tohide;
  final String msg;
  final String label;
  final Widget prefixIcon;
  const CommonTextFormField({
    Key? key,
    required this.controller,
    required this.tohide,
    required this.msg,
    required this.label,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool _isPasswordWeak = false;
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: widget.tohide && obscureText,
          controller: widget.controller,
          onChanged: (value) {
            // Check password strength when the user types
            setState(() {
              _isPasswordWeak = isPasswordWeak(value);
            });
          },
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.tohide
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,
            labelText: widget.label,
            labelStyle: const TextStyle(),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return widget.msg;
            } else if (widget.tohide && _isPasswordWeak) {
              // Show password strength error message
              return 'Password is too weak!';
            }
            return null;
          },
        ),
        if (widget.tohide && _isPasswordWeak)
          const Text(
            'Password is too weak!',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  bool isPasswordWeak(String password) {
    // Example: Check if the password is at least 6 characters long
    return password.length < 6;
  }
}
