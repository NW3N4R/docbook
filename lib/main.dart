import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Models/patientmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Services/patientshelper.dart';
import 'package:docbook/customWidgets/navbuttons.dart';
import 'package:flutter/material.dart';
import 'Services/main_service.dart';

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
          'DocBook',
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
              Service.openDb();
            },
          ),
        ],
      ),
      body: Center(child: Text('DocBook App')),
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
