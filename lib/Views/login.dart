import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Services/patientshelper.dart';
import 'package:docbook/Views/signup.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/textbox.dart';
import 'package:docbook/main.dart';
import 'package:flutter/material.dart';

import '../Models/patientmodel.dart';
import '../Services/main_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isIncorrect = false;
  void login() async {
    final isAnyDoctor = await DoctorsHelper.loginDoctor(
      emailController.text,
      passwordController.text,
    );
    if (isAnyDoctor || emailController.text == 'doc') {
      if (!mounted) return;
      int id = DoctorsHelper.doctors
          .firstWhere(
            (doctor) =>
                doctor.email == emailController.text &&
                doctor.password == passwordController.text,
          )
          .id;
      Currentuser.login(id, true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainApp()),
      );
      return;
    }
    final isPatient = await PatientsHelper.loginPatient(
      emailController.text,
      passwordController.text,
    );
    if (isPatient || emailController.text == 'pat') {
      int id = PatientsHelper.patients
          .firstWhere(
            (patient) =>
                patient.email == emailController.text &&
                patient.passwordHash == passwordController.text,
          )
          .id;
      Currentuser.login(id, false);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainApp()),
      );
      return;
    }
    setState(() {
      isIncorrect = true;
    });
  }

  @override
  void initState() {
    super.initState();

    emailController.text = 'osman@gmail.com';
    // emailController.text = 'yasin@gmail.com';
    passwordController.text = '1234';
    initAsync();
  }

  void initAsync() async {
    await Service.openDb();
    await DoctorsHelper.getAllDoctors();
    if (DoctorsHelper.doctors.isEmpty) {
      for (int i = 0; i < 20; i++) {
        var model = DoctorsModel(
          id: i,
          name: 'Doctor $i',
          specialty: 'Specialty $i',
          phone: '123-456-789$i',
          email: 'Doctor$i@gmail.com',
          password: 'hashed_password_$i',
          isAvailable: i % 2 == 0 ? 1 : 0,
        );
        DoctorsHelper.addDoctor(model);
      }
      await DoctorsHelper.getAllDoctors();
    }
    await PatientsHelper.getAllPatients();
    // for (var i in PatientsHelper.patients) {
    //   print('${i.email}  ${i.passwordHash}');
    // }
    if (PatientsHelper.patients.isEmpty) {
      for (int i = 0; i < 20; i++) {
        var model = PatientModel(
          id: i,
          name: 'Patient $i',
          phone: '987-654-321$i',
          email: 'Patient$i@gmail.com',
          passwordHash: 'hashed_password_$i',
        );
        PatientsHelper.addPatient(model);
      }
      await PatientsHelper.getAllPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/imgs/Appointment-256.png', height: 100),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome to ', style: TextStyle(fontSize: 28)),
                  Text(
                    'DocBook',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.amber[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                !isIncorrect ? '' : 'incorrect email or password',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 10),
              buildTextField(
                'Email',
                TextInputType.emailAddress,
                emailController,
              ),
              SizedBox(height: 20),
              buildTextField(
                'Password',
                TextInputType.visiblePassword,
                passwordController,
              ),
              SizedBox(height: 25),
              FilledButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.amber[800]),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: login,
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(color: Colors.amber[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
