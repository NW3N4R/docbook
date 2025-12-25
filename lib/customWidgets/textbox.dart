import 'package:flutter/material.dart';

TextField buildTextField(
  String labelText,
  TextInputType keyboardType,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    obscureText: keyboardType == TextInputType.visiblePassword,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.black, // 👈 label text color
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.amber[600]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.amber[800]!),
      ),
    ),
  );
}
