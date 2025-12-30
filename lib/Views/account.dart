import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
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

class _AccountViewState extends State<AccountView> {
  bool isReadOnly = true;
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
        isAvailable: 1,
      );
      DoctorsHelper.updateDoctor(newdoc);
      DoctorsHelper.getAllDoctors();
      setState(() {
        Currentuser.name = nameCtor.text;
        Currentuser.login(doc.id, true);
      });
    } else {}
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
                ? doctorProfileView(isReadOnly)
                : patientProfileView(isReadOnly),
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
                          onPressed: Currentuser.isDoctor ? updateDoc : () {},
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

Widget doctorProfileView(bool isReadOnly) {
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
    ],
  );
}

Widget patientProfileView(bool isReadOnly) {
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
      accountTextField('Speciality', specCtor, readOnly: isReadOnly),
    ],
  );
}
