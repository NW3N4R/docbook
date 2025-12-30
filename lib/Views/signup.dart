import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Models/patientmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Services/patientshelper.dart';
import 'package:docbook/Views/login.dart';
import 'package:docbook/customWidgets/textbox.dart';
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

  void docSignUp() {
    if (nameCtor.text == '' || emailCtor.text == '' || passCtor.text == '') {
      setState(() {
        errortext = 'All Fields are Required';
      });
      return;
    }
    setState(() {
      errortext = '';
    });
    DoctorsHelper.getAllDoctors();
    int newId = DoctorsHelper.doctors.length + 1;
    var doc = DoctorsModel(
      id: newId,
      name: nameCtor.text,
      email: emailCtor.text,
      password: passCtor.text,
      specialty: specCtor.text,
      phone: phoneCtor.text,
      isAvailable: 1,
    );
    DoctorsHelper.addDoctor(doc);
    DoctorsHelper.getAllDoctors();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (Route<dynamic> route) => false,
    );
  }

  void patSignUp() {
    PatientsHelper.getAllPatients();
    int newId = PatientsHelper.patients.length + 1;
    var patients = PatientModel(
      id: newId,
      name: nameCtor.text,
      phone: phoneCtor.text,
      email: emailCtor.text,
      passwordHash: passCtor.text,
      dateOfBirth: dateOfBirth,
      gender: selectedGender,
    );
    PatientsHelper.addPatient(patients);
    PatientsHelper.getAllPatients();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
      (Route<dynamic> route) => false,
    );
  }

  String signUpAs = "Doctor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Sign Up As'),
                DropdownButton<String>(
                  value: signUpAs,
                  hint: Text('Select Gender'),
                  items: ['Doctor', 'Patient'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    changeSignUpAs(newValue);
                  },
                ),
                Text(errortext, style: TextStyle(color: Colors.red)),
                signUpAs == "Doctor"
                    ? doctorProfileView()
                    : patientProfileView(_selectDate, changeGender),
                SizedBox(height: 50),
                TextButton(
                  onPressed: signUpAs == "Doctor" ? docSignUp : patSignUp,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.amber[800]),
                  ),
                  child: Text('Signup', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget doctorProfileView() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 10),
      buildTextField('Name', TextInputType.text, nameCtor),
      SizedBox(height: 20),
      buildTextField('Email', TextInputType.text, emailCtor),
      SizedBox(height: 20),
      buildTextField('Password', TextInputType.text, passCtor),
      SizedBox(height: 20),
      buildTextField('Speciality', TextInputType.text, specCtor),
      SizedBox(height: 20),
      buildTextField('Phone', TextInputType.text, phoneCtor),
    ],
  );
}

Widget patientProfileView(
  Future<void> Function() selectDate,
  Function changeGender,
) {
  return Column(
    children: [
      SizedBox(height: 10),
      buildTextField('Name', TextInputType.text, nameCtor),
      SizedBox(height: 20),
      buildTextField('Email', TextInputType.text, emailCtor),
      SizedBox(height: 20),
      buildTextField('Phone', TextInputType.text, phoneCtor),
      SizedBox(height: 20),
      buildTextField('Password', TextInputType.text, passCtor),
      SizedBox(height: 20),
      TextButton(
        onPressed: () {
          selectDate();
        },
        child: Text(dateOfBirth),
      ),
      SizedBox(height: 20),
      Text('Gender'),
      DropdownButton<String>(
        value: selectedGender,
        hint: Text('Select Gender'),
        items: ['Male', 'Female'].map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? newValue) {
          changeGender(newValue);
        },
      ),
    ],
  );
}
