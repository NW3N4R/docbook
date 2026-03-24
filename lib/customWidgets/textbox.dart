import 'package:flutter/material.dart';

Widget buildTextField(
  String labelText,
  TextInputType keyboardType,
  TextEditingController controller,
  BuildContext context, {
  bool isObsecure = false,
  bool readOnly = false,
  String hint = "",
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onSuffixClick,
  FormFieldValidator? validate
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(labelText),
      SizedBox(height: 6),
      TextFormField(
        controller: controller,
        obscureText: isObsecure,
        keyboardType: keyboardType,
        validator: validate,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceContainer,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixClick != null
                      ? () => onSuffixClick()
                      : null,
                )
              : null,

          hintText: hint == "" ? labelText : hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    ],
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
