import 'package:flutter/material.dart';

class Schedule extends StatefulWidget {
  final int docID;
  const Schedule(this.docID, {super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late final String docName;
  late final String patName;
  late String selectedDateStr = '';
  late String selectedTimeStr = '';
  final noteTXT = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  DateTime? selectedDate = DateTime.now();
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 120)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        if (selectedDate != null) {
          selectedDateStr =
              '${selectedDate?.year}-${selectedDate?.month}-${selectedDate?.day}';
        }
      });
    }
  }

  TimeOfDay? selectedTime = TimeOfDay.now();
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? const TimeOfDay(hour: 9, minute: 0),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
        if (selectedTime != null) {
          String amOrpm = selectedTime!.period
              .toString()
              .split('.')[1]
              .toString();
          selectedTimeStr =
              '${selectedTime?.hour}:${selectedTime?.minute}:$amOrpm';
        }
      });
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Schedule appointment',
          style: TextStyle(
            color: Colors.amber[800],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'DR.$docName',
              style: TextStyle(fontSize: 24, color: Colors.orange),
            ),
            SizedBox(height: 30),
            Text('Appointment date $selectedDateStr'),
            TextButton(
              onPressed: _selectDate,
              child: Text(
                'Select Date',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            SizedBox(height: 30),
            Text('Appointment time $selectedTimeStr'),
            TextButton(
              onPressed: _selectTime,
              child: Text(
                'Select Time',
                style: TextStyle(color: Colors.orange),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(12.0),
              // child: buildTextField('Note', TextInputType.text, noteTXT),
            ),
            SizedBox(height: 30),
            // ElevatedButton(
            //   onPressed: setSchedule,
            //   child: Text(
            //     'Set Schedule',
            //     style: TextStyle(color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
