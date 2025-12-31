import 'package:docbook/Views/account.dart';
import 'package:docbook/Views/patientappointment.dart';
import 'package:docbook/Views/patientshome.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/navbuttons.dart';
import 'package:flutter/material.dart';

int currentIndex = 0;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void onNavTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'DocBook -', // Use the parameter
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.amber[800],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const AccountView(),
                ),
              );
            },
          ),
        ],
      ),
      body: currentIndex == 0
          ? Currentuser.isDoctor
                ? Center(child: Text('Doc Home'))
                : PatientHome()
          : Currentuser.isDoctor
          ? Center(child: Text('Doc History'))
          : PatAppointView(),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisSize: MainAxisSize.min, // Shrinks the Row to fit its children
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Centers the buttons
          children: [
            ButtonWidget(
              text: 'Home',
              icon: Icons.home,
              onPressed: () => onNavTap(0),
              index: 0,
              currentIndex: currentIndex,
            ),
            ButtonWidget(
              text: 'List',
              icon: Icons.schedule,
              onPressed: () => onNavTap(1),
              index: 1,
              currentIndex: currentIndex,
            ),
          ],
        ),
      ),
    );
  }
}
