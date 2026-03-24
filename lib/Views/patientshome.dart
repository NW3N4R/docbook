import 'package:flutter/material.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomState();
}

class _PatientHomState extends State<PatientHome> {
  final searchTXT = TextEditingController();
  // var doctors = DoctorsHelper.doctors.where((x) => x.isAvailable == 1).toList();
  @override
  void initState() {
    super.initState();
  }

  void search(String text) {
    // setState(() {
    //   if (text == '') {
    //     doctors = DoctorsHelper.doctors
    //         .where((x) => x.isAvailable == 1)
    //         .toList();
    //   } else {
    //     doctors = DoctorsHelper.doctors
    //         .where(
    //           (x) =>
    //               x.isAvailable == 1 &&
    //               (x.name.toLowerCase().contains(text.toLowerCase()) ||
    //                   x.specialty.toLowerCase().contains(text.toLowerCase())),
    //         )
    //         .toList();
    //   }
    // });
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(children: [Text('data')]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
