import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  GestureTapCallback? onTap,
}) {
  final defaultBackColor = Theme.brightnessOf(context) == Brightness.dark
      ? AppThemes.fieldBackDark
      : AppThemes.fieldBackLight;
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
        readOnly: readOnly,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? defaultBackColor,
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
  final defaultBackColor = Theme.brightnessOf(context) == Brightness.dark
      ? AppThemes.fieldBackDark
      : AppThemes.fieldBackLight;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label),
      SizedBox(height: 6),
      DropdownButtonFormField<String>(
        initialValue: items.contains(value) ? value : items.first,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor ?? defaultBackColor,
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

Future<String> pickDate(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2030),
  );
  if (pickedDate == null) return '';
  final DateTime dateTime = DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
  );

  return DateFormat('dd-MM-yyyy').format(dateTime);
}

Future<String?> pickTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime == null) return '';
  final DateTime time = DateTime(
    2026,
    1,
    1,
    pickedTime.hour,
    pickedTime.minute,
  );
  int hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
  final String period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour12:${time.minute} $period';
}
