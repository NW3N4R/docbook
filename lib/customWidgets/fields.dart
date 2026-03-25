import 'package:docbook/themes.dart';
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
  FormFieldValidator? validate,
  Color? fillColor,
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
          fillColor: fillColor ?? AppThemes.fieldBackDark,
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
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    ],
  );
}

Column dropdown(
  String label,
  String? value,
  List<String> items,
  BuildContext context,
  void Function(String?) onChanged, {
  Color? fillColor,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onSuffixClick,
  FormFieldValidator? validate,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      SizedBox(height: 6,),
      DropdownButtonFormField<String>(
        initialValue: items.contains(value) ? value : items.first,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? AppThemes.fieldBackDark,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: onSuffixClick != null
                      ? () => onSuffixClick()
                      : null,
                )
              : null,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        validator: (v) {
          if (v == null || v == 'Status') return '$label is Required';
          return null;
        },
      ),
      SizedBox(height: 20),
    ],
  );
}
