import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

final nameCtor = TextEditingController();
final emailCtor = TextEditingController();
final passCtor = TextEditingController();
final specCtor = TextEditingController();
final phoneCtor = TextEditingController();
final isAvailableCtor = TextEditingController();
String dateOfBirth = 'Select Date of Birth';
String selectedGender = 'Male';

class _SignupState extends State<Signup> {
  String errortext = '';
  bool isReadOnly = true;
  DateTime? selectedDate = DateTime(2000);
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2000),
    );

    setState(() {
      selectedDate = pickedDate;
      if (selectedDate != null) {
        dateOfBirth =
            '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
      }
    });
  }

  void changeGender(String newGender) {
    setState(() {
      selectedGender = newGender;
    });
  }

  void changeSignUpAs(String? signupas) {
    setState(() {
      signUpAs = signupas ?? 'Doctor';
    });
  }

  String signUpAs = "Doctor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('Sign up'),
      ),
      body: SafeArea(child: Center()));
  }
}
