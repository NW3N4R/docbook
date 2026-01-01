import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:flutter/material.dart';

import '../Services/appointmenthelper.dart';

class PatAppointView extends StatefulWidget {
  const PatAppointView({super.key});

  @override
  State<PatAppointView> createState() => _PatAppointViewState();
}

class _PatAppointViewState extends State<PatAppointView> {
  final usr = Currentuser.getCurrentPatient();

  late List<AppointmentModel> appoints = [];
  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    await AppointmentHelper.getAllAppointments();
    setState(() {
      appoints = AppointmentHelper.appointments
          .where((x) => x.patientId == usr!.id)
          .toList();
    });
  }

  void deleteAppo(int id) {
    AppointmentHelper.deleteAppointment(id);
    AppointmentHelper.getAllAppointments();
    setState(() {
      appoints.removeWhere((a) => a.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: appoints.length,
        itemBuilder: (context, index) {
          final appointment = appoints[index];
          return Dismissible(
            key: ValueKey(appoints[index].id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              deleteAppo(appointment.id);
            },
            child: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: Colors.orange, width: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DoctorsHelper.doctors
                              .firstWhere(
                                (x) => x.id == appoints[index].doctorId,
                              )
                              .name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          DoctorsHelper.doctors
                              .firstWhere(
                                (x) => x.id == appoints[index].doctorId,
                              )
                              .specialty,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(appoints[index].appointmentDate),
                      Text(appoints[index].appointmentTime),
                      Text(appoints[index].status),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
