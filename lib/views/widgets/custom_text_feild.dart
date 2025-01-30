import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.hintText,
    this.onSave,
    this.maxLine = 1,
    this.onChanged,
    this.controller,
  });

  final String? hintText;
  final int maxLine;
  final void Function(String?)? onSave;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSave,
      onChanged: onChanged,
      maxLines: maxLine,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Field is required ';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        border: outlineInputBorder(),
      ),
    );
  }

  outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 220, 220, 220),
      ),
      borderRadius: BorderRadius.circular(16),
    );
  }
}
