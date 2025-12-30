import 'package:flutter/material.dart';

TextField buildTextField(
  String labelText,
  TextInputType keyboardType,
  TextEditingController controller, [
  bool readOnly = false,
]) {
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

TextField accountTextField(
  String labelText,
  TextEditingController controller, {
  bool isPass = false,
  bool readOnly = false,
}) {
  return TextField(
    controller: controller,
    readOnly: readOnly,
    obscureText: isPass,
    keyboardType: isPass ? TextInputType.visiblePassword : TextInputType.text,
    textAlign: TextAlign.center,
    decoration: InputDecoration(
      labelText: !readOnly ? labelText : '',

      labelStyle: TextStyle(color: Colors.black),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    ),
  );
}
