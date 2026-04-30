import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Services/appointmenthelper.dart';
import 'package:docbook/Services/usershelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AppointmentsView extends StatefulWidget {
  const AppointmentsView({super.key});

  @override
  State<AppointmentsView> createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  List<AppointmentModel> appoints = [];
  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    await AppointmentHelper.getAllAppointments();
    appoints = AppointmentHelper.appointments
        .where(
          (x) =>
              x.doctorId == Currentuser.loggedUser!.id ||
              x.patientId == Currentuser.loggedUser!.id,
        )
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(locale!.myAppointments)),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: appoints.length,
          itemBuilder: (context, index) {
            var currentAppoint = appoints[index];
            var user = UsersHelper.users.firstWhere(
              (x) =>
                  x.id == currentAppoint.doctorId ||
                  x.id == currentAppoint.patientId,
            );
            return Dismissible(
              key: Key(currentAppoint.id.toString()),
              background: Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) async {
                await AppointmentHelper.deleteAppointment(currentAppoint.id);
                load();
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  isThreeLine: false,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          getStatusAsIcon(currentAppoint.status),
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    user.fullName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    '${currentAppoint.appointmentDate} ${currentAppoint.appointmentTime}\n${user.phone}${currentAppoint.notes != null ? "\n${currentAppoint.notes}" : ""}',
                  ),
                  trailing:currentAppoint.patientId == Currentuser.loggedUser!.id ? null :  PopupMenuButton(
                    onSelected: (value) async {
                      var model = AppointmentModel(
                        id: currentAppoint.id,
                        doctorId: currentAppoint.doctorId,
                        patientId: currentAppoint.patientId,
                        appointmentDate: currentAppoint.appointmentDate,
                        appointmentTime: currentAppoint.appointmentTime,
                        status: int.parse(value.toString()),
                        createdAt: currentAppoint.createdAt,
                        notes: currentAppoint.notes,
                      );
                      await AppointmentHelper.updateAppointment(model);
                      load();
                    },
                    itemBuilder: (BuildContext contenxt) => [
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          leading: Icon(Icons.done),
                          title: Text(locale.accept),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: ListTile(
                          leading: Icon(Icons.close),
                          title: Text(locale.reject),
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: ListTile(
                          leading: Icon(Icons.done_all),
                          title: Text(locale.completed),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData getStatusAsIcon(int status) {
    switch (status) {
      case 0:
        return Icons.access_time_rounded;
      case 1:
        return Icons.done;
      case 2:
        return Icons.close;
      case 3:
        return Icons.done_all;
    }
    return Icons.question_mark_sharp;
  }
}
