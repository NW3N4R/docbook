import 'package:docbook/Models/doctorsmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Views/schedule.dart';
import 'package:flutter/material.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomState();
}

class _PatientHomState extends State<PatientHome> {
  final searchTXT = TextEditingController();
  var doctors = DoctorsHelper.doctors.where((x) => x.isAvailable == 1).toList();
  @override
  void initState() {
    super.initState();
  }

  void search(String text) {
    setState(() {
      if (text == '') {
        doctors = DoctorsHelper.doctors
            .where((x) => x.isAvailable == 1)
            .toList();
      } else {
        doctors = DoctorsHelper.doctors
            .where(
              (x) =>
                  x.isAvailable == 1 &&
                  (x.name.toLowerCase().contains(text.toLowerCase()) ||
                      x.specialty.toLowerCase().contains(text.toLowerCase())),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            onChanged: search,
            decoration: InputDecoration(labelText: 'Search ...'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of columns
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9, // card shape
              ),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return Column(children: [doctorCard(doctors[index], context)]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget doctorCard(DoctorsModel doctor, BuildContext context) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber[800]!, width: 0.5),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.amber[800],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                doctor.name[0],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 38),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(doctor.name),
          SizedBox(height: 10),
          Text(doctor.specialty),
          Expanded(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Schedule(doctor.id)),
                );
              },
              child: Text(
                'Schedule',
                style: TextStyle(color: Colors.amber[800]),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
