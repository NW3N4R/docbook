import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Models/patientmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Services/patientshelper.dart';
import 'package:docbook/Views/login.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/textbox.dart';
import 'package:flutter/material.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

final nameCtor = TextEditingController();
final emailCtor = TextEditingController();
final passCtor = TextEditingController();
final specCtor = TextEditingController();
final phoneCtor = TextEditingController();
final isAvailableCtor = TextEditingController();
String dateOfBirth = '2000-1-1';
String selectedGender = 'Male';

class _AccountViewState extends State<AccountView> {
  bool isReadOnly = true;
  bool isAvailable = Currentuser.isDoctor
      ? Currentuser.getCurrentDocots()?.isAvailable == 1
      : false;
  DateTime? selectedDate;

  @override
  void initState() {
    if (Currentuser.isDoctor) {
      final doc = Currentuser.getCurrentDocots();
      nameCtor.text = doc?.name ?? '';
      emailCtor.text = doc?.email ?? '';
      passCtor.text = doc?.password ?? '';
      specCtor.text = doc?.specialty ?? '';
      phoneCtor.text = doc?.phone ?? '';
      isAvailableCtor.text = doc?.isAvailable.toString() ?? '';
    } else {
      final pat = Currentuser.getCurrentPatient();
      nameCtor.text = pat?.name ?? '';
      emailCtor.text = pat?.email ?? '';
      passCtor.text = pat?.passwordHash ?? '';
      phoneCtor.text = pat?.phone ?? '';

      if (pat == null || pat.dateOfBirth == null) {
        selectedDate = DateTime(2000);
      } else {
        List<String> dateParts = pat.dateOfBirth!.split('-');
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int day = int.parse(dateParts[2]);
        selectedDate = DateTime(year, month, day);
      }
      dateOfBirth =
          pat?.dateOfBirth ??
          '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}';
      selectedGender = pat?.gender ?? 'Male';
    }
    super.initState();
  }

  void updateDoc() {
    final doc = Currentuser.getCurrentDocots();
    if (doc != null) {
      var newdoc = DoctorsModel(
        id: doc.id,
        name: nameCtor.text,
        email: emailCtor.text,
        password: passCtor.text,
        specialty: specCtor.text,
        phone: phoneCtor.text,
        isAvailable: isAvailable ? 1 : 0,
      );
      DoctorsHelper.updateDoctor(newdoc);
      DoctorsHelper.getAllDoctors();
      setState(() {
        Currentuser.name = nameCtor.text;
        Currentuser.login(doc.id, true);
      });
    }
  }

  void isAvailableChanged(bool? isavail) {
    setState(() {
      isAvailable = isavail ?? false;
    });
  }

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

  void updatePat() {
    final pat = Currentuser.getCurrentPatient();
    if (pat != null) {
      var newdoc = PatientModel(
        id: pat.id,
        name: nameCtor.text,
        email: emailCtor.text,
        passwordHash: passCtor.text,
        phone: phoneCtor.text,
        gender: selectedGender,
        dateOfBirth: dateOfBirth,
      );
      PatientsHelper.updatePatient(newdoc);
      PatientsHelper.getAllPatients();
      setState(() {
        Currentuser.name = nameCtor.text;
        Currentuser.login(pat.id, false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Account'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Currentuser.isDoctor
                ? doctorProfileView(isReadOnly, isAvailableChanged, isAvailable)
                : patientProfileView(isReadOnly, _selectDate, changeGender),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Currentuser.logout();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.amber[800],
                      ),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isReadOnly = !isReadOnly;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        Colors.amber[800],
                      ),
                    ),
                    child: Text('Edit', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 20),
                  isReadOnly
                      ? SizedBox()
                      : TextButton(
                          onPressed: Currentuser.isDoctor
                              ? updateDoc
                              : updatePat,
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Colors.amber[800],
                            ),
                          ),
                          child: Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget doctorProfileView(
  bool isReadOnly,
  ValueChanged<bool?>? isAvailableChanged,
  bool isAvailable,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.amber[800],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            Currentuser.name?[0] ?? '',
            style: TextStyle(color: Colors.white, fontSize: 48),
          ),
        ),
      ),
      SizedBox(height: 10),
      accountTextField('Name', nameCtor, readOnly: isReadOnly),
      accountTextField('Email', emailCtor, readOnly: isReadOnly),
      accountTextField(
        'Password',
        passCtor,
        isPass: isReadOnly,
        readOnly: isReadOnly,
      ),
      accountTextField('Speciality', specCtor, readOnly: isReadOnly),
      accountTextField('Phone', phoneCtor, readOnly: isReadOnly),
      Row(
        children: [
          Checkbox(
            value: isAvailable,
            onChanged: isReadOnly ? null : isAvailableChanged,
          ),
          Text('is Available'),
        ],
      ),
    ],
  );
}

Widget patientProfileView(
  bool isReadOnly,
  Future<void> Function() selectDate,
  Function changeGender,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.amber[800],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            Currentuser.name?[0] ?? '',
            style: TextStyle(color: Colors.white, fontSize: 48),
          ),
        ),
      ),
      SizedBox(height: 10),
      accountTextField('Name', nameCtor, readOnly: isReadOnly),
      accountTextField('Email', emailCtor, readOnly: isReadOnly),
      accountTextField('Phone', phoneCtor, readOnly: isReadOnly),
      accountTextField(
        'Password',
        passCtor,
        isPass: isReadOnly,
        readOnly: isReadOnly,
      ),
      Text(dateOfBirth),
      isReadOnly
          ? SizedBox()
          : TextButton(
              onPressed: () {
                selectDate();
              },
              child: Text('Select Date of Birth'),
            ),
      Text('Gender $selectedGender'),
      isReadOnly
          ? SizedBox()
          : DropdownButton<String>(
              value: selectedGender,
              hint: Text('Select Gender'),
              items: ['Male', 'Female'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                changeGender(newValue);
              },
            ),
    ],
  );
}
