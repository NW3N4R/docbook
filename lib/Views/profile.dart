import 'package:docbook/Models/appointmentsmodel.dart';
import 'package:docbook/Services/appointmenthelper.dart';
import 'package:docbook/currentuser.dart';
import 'package:docbook/customWidgets/fields.dart';
import 'package:docbook/l10n/app_localizations.dart';
import 'package:docbook/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:toastification/toastification.dart';
import 'package:docbook/Models/usersmodel.dart';

class DoctorProfile extends StatefulWidget {
  final UsersModel user;

  const DoctorProfile({super.key, required this.user});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.profileDetails,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            CircleAvatar(
              radius: 50,
              backgroundColor: colorScheme.primary,
              child: Text(
                widget.user.fullName.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.user.fullName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            Text(
              widget.user.profession,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildDetailTile(
                    Icons.badge_outlined,
                    locale!.id,
                    widget.user.id.toString(),
                  ),
                  _divider(),
                  _buildDetailTile(
                    Icons.phone_outlined,
                    locale.phone,
                    widget.user.phone,
                  ),
                  _divider(),
                  _buildDetailTile(
                    Icons.location_on_outlined,
                    locale.address,
                    widget.user.address,
                  ),
                  _divider(),
                  _buildDetailTile(
                    Icons.person_outline,
                    locale.gender,
                    widget.user.gender == 1
                        ? locale.male
                        : locale.female, // Simple logic example
                  ),
                  _divider(),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionChip(
                  avatar: const Icon(
                    Icons.phone,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(locale!.phoneCall),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha(70),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withAlpha(120),
                    width: 1.5,
                  ),
                  shape: StadiumBorder(),
                  onPressed: () async {
                    bool? res = await FlutterPhoneDirectCaller.callNumber(
                      widget.user.phone,
                    );

                    if (res == false) {
                      showToast(
                        locale.errorHappened,
                        locale.errorHappened,
                        ToastificationType.error,
                        context,
                      );
                    }
                  },
                ),
                ActionChip(
                  avatar: const Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: Colors.white,
                  ),
                  label: Text(locale.reqAppointMent),
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withAlpha(70),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.primary.withAlpha(120),
                    width: 1.5,
                  ),
                  shape: StadiumBorder(),
                  onPressed: () => setAppointment(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String label, String value) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        label,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      indent: 60,
      endIndent: 16,
      color: Colors.black.withOpacity(0.05),
    );
  }

  void setAppointment() async {
    var locale = AppLocalizations.of(context);
    final dateCtor = TextEditingController();
    final timeCtor = TextEditingController();
    final notesCtor = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      isScrollControlled: true, // Recommended since you have a form/keyboard
      showDragHandle: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildTextField(
                        locale!.appoDate,
                        TextInputType.datetime,
                        dateCtor,
                        context,
                        prefixIcon: Icons.calendar_month,
                        readOnly: true,
                        onTap: () async {
                          dateCtor.text = await pickDate(context);
                        },
                        validate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return locale.appoDateReq;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        locale.appoTime,
                        TextInputType.datetime,
                        timeCtor,
                        context,
                        prefixIcon: Icons.timelapse,
                        readOnly: true,
                        onTap: () async {
                          timeCtor.text = await pickTime(context) ?? "";
                        },
                        validate: (value) {
                          if (value == null || value.toString().isEmpty) {
                            return locale.appoTimeReq;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      buildTextField(
                        locale.note,
                        TextInputType.text,
                        notesCtor,
                        context,
                        prefixIcon: Icons.text_decrease,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            var appoint = AppointmentModel(
                              id: 0,
                              doctorId: widget.user.id,
                              patientId: Currentuser.loggedUser!.id,
                              appointmentDate: dateCtor.text,
                              appointmentTime: timeCtor.text,
                              status: AppointmentStatusModel.toInt(
                                AppointmentStatus.ongoing,
                              ),
                              notes: notesCtor.text,
                              createdAt: DateTime.now().toString(),
                            );
                            int newId = await AppointmentHelper.addAppointment(
                              appoint,
                            );
                            if (newId > 0) {
                              showToast(
                                locale.actionSuccess,
                                locale.actionSuccess,
                                ToastificationType.success,
                                context,
                              );
                              Navigator.pop(context);
                            } else {
                              showToast(
                                locale!.errorHappened,
                                locale.actionFailure,
                                ToastificationType.success,
                                context,
                              );
                            }
                          }
                        },
                        child: Text(locale.sendRequest),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
