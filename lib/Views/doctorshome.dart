import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Services/appointmenthelper.dart';
import 'package:docbook/Services/doctorshelper.dart';
import 'package:docbook/Services/patientshelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  late List<AppointmentModel> appoints = [];
  late final currentDoc = Currentuser.getCurrentDocots();
  @override
  void initState() {
    initAsync();
    super.initState();
  }

  void initAsync() async {
    await AppointmentHelper.getAllAppointments();
    setState(() {
      appoints = AppointmentHelper.appointments
          .where((x) => x.doctorId == currentDoc!.id)
          .toList();
    });
  }

  void updateStatus(String status, int id) {
    var appoint = AppointmentHelper.appointments.firstWhere((x) => x.id == id);
    var model = AppointmentModel(
      id: id,
      doctorId: appoint.doctorId,
      patientId: appoint.patientId,
      appointmentDate: appoint.appointmentDate,
      appointmentTime: appoint.appointmentTime,
      status: status,
      createdAt: appoint.createdAt,
    );
    AppointmentHelper.updateAppointment(model);
    AppointmentHelper.getAllAppointments();
    initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: appoints.length,
        itemBuilder: (context, index) {
          final appointment = appoints[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(color: getbg(appointment.status), width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            PatientsHelper.patients
                                .firstWhere(
                                  (x) => x.id == appointment.patientId,
                                )
                                .name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            PatientsHelper.patients
                                .firstWhere(
                                  (x) => x.id == appointment.patientId,
                                )
                                .phone,
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    bttn('inline', appointment.id, updateStatus),
                    bttn('cancelled', appointment.id, updateStatus),
                    bttn('accepted', appointment.id, updateStatus),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

TextButton bttn(String text, int id, void Function(String status, int id) up) {
  return TextButton(
    onPressed: () => up(text, id),
    child: Text(text, style: TextStyle(color: Colors.orange)),
  );
}

Color getbg(String text) {
  if (text == 'inline') {
    return Colors.amber;
  } else if (text == 'cancelled') {
    return Colors.red;
  } else if (text == 'accepted') {
    return Colors.green;
  }
  return Colors.transparent;
}
